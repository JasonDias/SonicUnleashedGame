<?php
/**
 * Game Service API for Sonic Unleashed
 * 
 
 	=== Possible error responses: ===
	
	:: submitHighScore ::
	
	E01|Name must be exactly 3 letters long.
	E02|Name must contain only letters A-Z.
	E03|Name must not be offensive.
	E04|Score must be greater than zero.
	E05|Could not open high scores file.
	E10|Invalid Game Name.
	
	
	:: clearHighScores ::
	
	E05|Could not open high scores file.
	E10|Invalid Game Name.
	
	
	:: getHighScores ::
	
	E10|Invalid Game Name.
	
	
	:: sendPostCard ::
	
	E06|Sender\'s name is invalid.
	E07|Sender\'s email is invalid.
	E08|Recipient\'s name is invalid.
	E09|Recipient\'s email is invalid.
 */

define('VALID_EMAIL', '/\\A(?:^([a-z0-9][a-z0-9_\\-\\.\\+]*)@([a-z0-9][a-z0-9\\.\\-]{0,63}\\.(com|org|net|biz|info|name|net|pro|aero|coop|museum|[a-z]{2,4}))$)\\z/i');

include_once(AMFPHP_BASE . 'shared/util/MethodTable.php');

class SonicGameService
{
	var $requiredNameLength		= 3;
	var $defaultNumberOfScores	= 20;
	var $maxNumberOfScores		= 20;
	var $postCardHTMLFileName	= 'postcard.html';
	var $dayGameName			= 'day';
	var $nightGameName			= 'night';
	var $highScoresFileName		= array(
		'day'					=> 'high_scores_day.txt',
		'night'					=> 'high_scores_night.txt'
	);
	
	function remote_echo($myValue){
		return $myValue;
	}

	function sendPostCard($fromName, $fromEmail, $toName, $toEmail){
		if(strlen($fromName) == 0){
			trigger_error('E06|Sender\'s name is invalid.');
		}
		
		if(!preg_match(VALID_EMAIL, $fromEmail)){
			trigger_error('E07|Sender\'s email is invalid.');
		}
		
		if(strlen($toName) == 0){
			trigger_error('E08|Recipient\'s name is invalid.');
		}
		
		if(!preg_match(VALID_EMAIL, $toEmail)){
			trigger_error('E09|Recipient\'s email is invalid.');
		}
	
		$phpMajorVersion	= explode('.', phpversion());
		$phpMajorVersion	= $phpMajorVersion[0];
		require_once('swiftmailer/php'.$phpMajorVersion.'/Swift.php');
		require_once('swiftmailer/php'.$phpMajorVersion.'/Swift/Connection/NativeMail.php');
		
		$finds			= array();
		$finds[]		= '[[to_name]]';
		$finds[]		= '[[from_name]]';
		$finds[]		= '[[game_url]]';
		$replaces		= array();
		$replaces[]		= $toName;
		$replaces[]		= $fromName;
		$replaces[]		= 'http://'.$_SERVER['HTTP_HOST'].'/';
		$html			= implode("\n", file($this->postCardHTMLFileName));
		$html			= str_replace($finds, $replaces, $html);
		eregi('<title>([^<]*)</title>', $html, $subject);

		$subject		= $subject[1];
		
		$swift			=& new Swift(new Swift_Connection_NativeMail());
		$message		=& new Swift_Message($subject, $html, 'text/html');
		
		$toAddress		=& new Swift_Address($toEmail, $toName);
		$fromAddress	=& new Swift_Address($fromEmail, $fromName);
		
		if($swift->send($message, $toAddress, $fromAddress)){
			$success	= true;
		}else{
			$success	= false;
		}
		$swift->disconnect();
		return $success;
	}
	
	function submitHighScore($myScore, $myName, $myGame){
		$myName		= strtoupper(str_replace(array(' ','|'),'',$myName));
		$myScore	= $myScore;
		$myGame		= strtolower(trim($myGame));
		if(strlen($myName) != $this->requiredNameLength){
			trigger_error('E01|Name must be exactly '.$this->requiredNameLength.' letters long.');
		}
		if(!preg_match('/^[A-Z]{3}$/', $myName)){
			trigger_error('E02|Name must contain only letters A-Z.');
		}
		if($this->_isProfane($myName)){
			trigger_error('E03|Name must not be offensive.');
		}
		if(!is_numeric($myScore) || $myScore < 1){
			trigger_error('E04|Score must be greater than zero.');
		}
		if(!in_array($myGame, array_keys($this->highScoresFileName))){
			trigger_error('E10|Invalid Game Name.');
		}
		$myScoreObj	= array(
			'name'	=> $myName,
			'score'	=> $myScore,
			'date'	=> $this->_millitime()
		);
		
		$lines		= file($this->highScoresFileName[$myGame]);//, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
		$scores		= array();
		foreach($lines as $line){
			$scores[]	= unserialize($line);
		}
		$scores		= $this->_insertScoreIntoScoresArray($myScoreObj, $scores);
		
		$serialized	= array();
		
		$scores		= array_shift(array_chunk($scores, $this->maxNumberOfScores));

		foreach($scores as $k=>$score){
			$serialized[] = serialize($score);
		}
		
		$data		= implode("\n", $serialized);
		$this->_writeDataToFile($this->highScoresFileName[$myGame], $data);
		return $scores;
	}
	
	function getHighScores($myGame, $myLimit = -1){
		if($myLimit < 1) $myLimit = $this->defaultNumberOfScores;
		$myGame		= strtolower(trim($myGame));
		if(!in_array($myGame, array_keys($this->highScoresFileName))){
			trigger_error('E10|Invalid Game Name.');
		}
		$data	= file($this->highScoresFileName[$myGame]);//, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
		$data	= array_shift(array_chunk($data, $myLimit));
		$output	= array();
		foreach($data as $value){
			$output[] = unserialize($value);
		}
		return $output;
	}
	
	function clearHighScores($myGame){
		$myGame		= strtolower(trim($myGame));
		if(!in_array($myGame, array_keys($this->highScoresFileName))){
			trigger_error('E10|Invalid Game Name.');
		}
		$data		= '';
		$dummyScore	= array(
			'name'	=> 'N',
			'score'	=> 600000,
			'date'	=> $this->_millitime()
		);
		$lines	= array();
		for($i = 0; $i < $this->defaultNumberOfScores; $i++){
			$dummyScore['name']	= 'N'.str_pad(($i+1), 2, '0', STR_PAD_LEFT);
			$lines[] = serialize($dummyScore);
		}
		$data	= implode("\n", array_shift(array_chunk($lines, $this->maxNumberOfScores)));
		$this->_writeDataToFile($this->highScoresFileName[$myGame], $data);
	}
	
	function _isProfane($myName){
		$bad = array();
		$bad[]	= 'ASS';
		$bad[]	= 'FUK';
		$bad[]	= 'FUX';
		$bad[]	= 'FUC';
		$bad[]	= 'FKU';
		$bad[]	= 'XXX';
		$bad[]	= 'CNT';
		$bad[]	= 'DIC';
		$bad[]	= 'DIK';
		$bad[]	= 'BUT';
		$bad[]	= 'FRT';
		$bad[]	= 'VAG';
		$bad[]	= 'VAJ';
		$bad[]	= 'TIT';
		
		return in_array($myName, $bad);
	}
	
	function _insertScoreIntoScoresArray($myScoreObj, $scores){
		$unique_scores	= array();
		$unique_key		= $myScoreObj['name'].'_'.$myScoreObj['score'];
		foreach($scores as $score){
			$score_unique_key	= $score['name'].'_'.$score['score'];
			$unique_scores[$score_unique_key]	= $score;
		}
		
		$unique_scores[$unique_key]	= $myScoreObj;
		
		//Sort by score high to low:
		$scores = array();
		$dates	= array();
		foreach($unique_scores as $k=>$v){
			$scores[$k]	= $v['score'];
			$dates[$k]	= $v['date'];
		}
		
		array_multisort($scores, SORT_NUMERIC, $dates, SORT_NUMERIC|SORT_DESC, $unique_scores);
		return $unique_scores;
	}
	
	function _writeDataToFile($fileName, $data){
		$fp	= fopen($fileName, 'w');
		if($fp){
			fputs($fp, $data);
			fclose($fp);
		}else{
			trigger_error('E05|Could not open high scores file.');
		}
	}
	
	function _millitime(){
		return round(microtime(true) * 1000);
	}
}