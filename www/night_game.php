<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sonic Unleashed Mini Games | Night Game</title>
<link rel="stylesheet" type="text/css" href="css/sonic.css" />
<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript">
	var swfW		= 640;
	var swfH		= 360;
	var flashvars	= {
		contentSWF:	'night_main.swf',
		width:		swfW,
		height:		swfH,
		gatewayURL:	'amfphp/gateway.php'
	};
	var params		= {};
		params.bgcolor	= '#000000';
		params.menu		= "false";
//		params.quality	= "low";
		params.scale	= "noscale";
		params.salign	= "tl";
	var attributes	= {};
	attributes.id	= "flashContent";
	swfobject.embedSWF("preloader_container.swf", "flashContent", swfW, swfH, "9.0.124", "expressInstall.swf", flashvars, params, attributes);
</script>
</head>
<body>
	<div id="flashContent">
		To play Sonic Unleashed mini games you will need to <a href="http://www.adobe.com/go/getflash" target="_blank">download the latest Adobe Flash Player</a>. Also make sure you have JavaScript enabled.
	</div>
</body>
</html>