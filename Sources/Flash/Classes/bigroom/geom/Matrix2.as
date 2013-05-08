/*
 * Author: Richard Lord
 * Copyright (c) Big Room Ventures Ltd. 2007
 * Version: 1.0.0
 * 
 * Licence Agreement
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package bigroom.geom 
{
	import flash.geom.Matrix;
	import bigroom.geom.Vector2;

	/**
	 * <p>Represents a matrix for 2d transformations. The properties mirror those
	 * of the flash.geom.Matrix class but this class contains many more methods.</p>
	 * 
	 * <p>To convert between this class and the flash.geom.Matrix class use the
	 * methods toMatrix and fromMatrix.</p>
	 */
	public class Matrix2 
	{
		/**
		 * A zero matrix.
		 */
		public static const ZERO:Matrix2 = new Matrix2( 0, 0, 0, 0, 0, 0 );
		
		/**
		 * An identity matrix.
		 */
		public static const IDENTITY:Matrix2 = new Matrix2( 1, 0, 0, 1, 0, 0 );
		
		/**
		 * Creates a Matrix2 object from a flash.geom.Matrix object. Used to
		 * convert a flash.geom.Matrix object to a Matrix2 object.
		 * 
		 * @param m the flash.geom.Matrix object to convert
		 * 
		 * @return the new Matrix2 object
		 */
		public static function fromMatrix( m:Matrix ):Matrix2
		{
			return new Matrix2( m.a, m.b, m.c, m.d, m.tx, m.ty );
		}
		
		/**
		 * Creates a new Matrix2 for scaling.
		 * 
		 * @param sx the scale factor in the x direction
		 * @param sy the scale factor in the y direction
		 * 
		 * @return the new matrix
		 */
		public static function newScale( sx:Number, sy:Number ):Matrix2
		{
			return new Matrix2( sx, 0, 0, sy, 0, 0 );
		}
		
		/**
		 * Creates a new Matrix2 for translation.
		 * 
		 * @param v a vector representing the translation
		 * 
		 * @return the new matrix
		 */
		public static function newTranslate( v:Vector2 ):Matrix2
		{
			return new Matrix2( 1, 0, 0, 1, v.x, v.y );
		}
	
		/**
		 * Creates a new Matrix2 for rotation about the origin.
		 * 
		 * @param r the angle in radians for the rotation
		 * 
		 * @return the new matrix
		 */
		public static function newRotate( r:Number ):Matrix2
		{
			if( r == 0 )
			{
				return Matrix2( IDENTITY.clone() );
			}
			var sin:Number = Math.sin( r );
			var cos:Number = Math.cos( r );
			return new Matrix2( cos, sin, -sin, cos, 0, 0 );
		}
		
		/**
		 * Creates a new Matrix2 for rotation about an arbitrary point.
		 * 
		 * @param r the angle in radians for the rotation
		 * @param p the point to rotate around
		 * 
		 * @return the new matrix
		 */
		public static function newRotateAboutPoint( r:Number, p:Vector2 ):Matrix2
		{
			if( r == 0 )
			{
				return Matrix2( IDENTITY.clone() );
			}
			var sin:Number = Math.sin( r );
			var cos:Number = Math.cos( r );
			return new Matrix2( cos, sin, -sin, cos, -cos * p.x + sin * p.y + p.x, -sin * p.x - cos * p.y + p.y );
		}
		
		/**
		 * Creates a matrix to translate global coordinates to local coordinates 
		 * with the x axis in direction specified.
		 * 
		 * @param origin the origin in the local coordinates
		 * @param heading the direction for the x axis in the local coordinates
		 * 
		 * @return the new matrix
		 */
		public static function localSpaceTransform( origin:Vector2, heading:Vector2 ):Matrix2
		{
			var h:Vector2 = heading.unit();
			return new Matrix2( h.x, h.y, -h.y, h.x,
							   - h.x * origin.x + h.y * origin.y,
							   - h.y * origin.x - h.x * origin.y );
		}
		
		/**
		 * The value in row 1 column 1 or the matrix.
		 */
		public var a:Number;
		/**
		 * The value in row 2 column 1 of the matrix.
		 */
		public var b:Number;
		/**
		 * The value in row 1 column 2 of the matrix.
		 */
		public var c:Number;
		/**
		 * The value in row 2 column 2 of the matrix.
		 */
		public var d:Number;
		/**
		 * The x translation value in row 1 column 3 of the matrix
		 */
		public var tx:Number;
		/**
		 * Th y translation value in row 2 column 3 of the matrix
		 */
		public var ty:Number;

		/**
		 * Constructor
		 * 
		 * @param pa the value for row 1 column 1 of the matrix
		 * @param pb the value for row 2 column 1 of the matrix
		 * @param pc the value for row 1 column 2 of the matrix
		 * @param pd the value for row 2 column 2 of the matrix
		 * @param ptx the x translation value for row 1 column 3 of the matrix
		 * @param pty the y translation value for row 2 column 3 of the matrix
		 */
		public function Matrix2( pa:Number = 1, pb:Number = 0, pc:Number = 0, pd:Number = 1, ptx:Number = 0, pty:Number = 0 )
		{
			a = pa;
			b = pb;
			c = pc;
			d = pd;
			tx = ptx;
			ty = pty;
		}
		
		/**
		 * Reset this matrix with new values
		 * 
		 * @param pa the value for row 1 column 1 of the matrix
		 * @param pb the value for row 2 column 1 of the matrix
		 * @param pc the value for row 1 column 2 of the matrix
		 * @param pd the value for row 2 column 2 of the matrix
		 * @param ptx the x translation value for row 1 column 3 of the matrix
		 * @param pty the y translation value for row 2 column 3 of the matrix
		 */
		public function reset( pa:Number = 1, pb:Number = 0, pc:Number = 0, pd:Number = 1, ptx:Number = 0, pty:Number = 0 ):Matrix2
		{
			a = pa;
			b = pb;
			c = pc;
			d = pd;
			tx = ptx;
			ty = pty;
			return this;
		}
		
		/**
		 * Copy another matrix into this one
		 * 
		 * @param m the matrix to copy
		 * 
		 * @return a reference to this matrix
		 */
		public function copy( m:Matrix2 ):Matrix2
		{
			a = m.a;
			b = m.b;
			c = m.c;
			d = m.d;
			tx = m.tx;
			ty = m.ty;
			return this;
		}
		
		/**
		 * Make a duplicate of this matrix
		 * 
		 * @return the new matrix
		 */
		public function clone():Matrix2
		{
			return new Matrix2( a, b, c, d, tx, ty );
		}
		
		/**
		 * Copy this matrix into a flash.geom.Matrix object.
		 * 
		 * @return the new flash.geom.Matrix object
		 */
		public function toMatrix():Matrix
		{
			return new Matrix( a, b, c, d, tx, ty );
		}

		/**
		 * Compare another matrix with this one
		 * 
		 * @param m the matrix to compare with
		 * 
		 * @return true if the matrices are the same, false otherwise
		 */
		public function equals( m:Matrix2 ):Boolean
		{
			if( m.a != a ) { return false; }
			if( m.b != b ) { return false; }
			if( m.c != c ) { return false; }
			if( m.d != d ) { return false; }
			if( m.tx != tx ) { return false; }
			if( m.ty != ty ) { return false; }
			return true;
		}

		/**
		 * Join another transformation matrix to this one
		 * 
		 * @param m the other transformation matrix
		 * 
		 * @return a reference to this matrix
		 */
		public function concat( m:Matrix2 ):Matrix2
		{
			var na:Number = a;
			var nb:Number = b;
			var nc:Number = c;
			var nd:Number = d;
			var nx:Number = tx;
			var ny:Number = ty;
			a = m.a * na + m.c * nb;
			b = m.b * na + m.d * nb;
			c = m.a * nc + m.c * nd;
			d = m.b * nc + m.d * nd;
			tx = m.a * nx + m.c * ny + m.tx;
			ty = m.b * nx + m.d * ny + m.ty;
			return this;
		}

		/**
		 * Add a scale transformation to this matrix
		 * 
		 * @param sx the scaling factor in the x direction
		 * @param sy the scaling factor in the y direction
		 * 
		 * @return a reference to this matrix
		 */
		public function scale( sx:Number, sy:Number ):Matrix2
		{
			var m:Matrix2 = newScale( sx, sy );
			return concat( m );
		}
		
		/**
		 * Add a translation transformation to this matrix
		 * 
		 * @param v the vector for the transformation
		 * 
		 * @return a reference to this matrix
		 */
		public function translate( v:Vector2 ):Matrix2
		{
			var m:Matrix2 = newTranslate( v );
			return concat( m );
		}
	
		/**
		 * Add a rotation transformation to this matrix
		 * 
		 * @param r the rotation in radians
		 * 
		 * @return a reference to this matrix
		 */
		public function rotate( r:Number ):Matrix2
		{
			if( r == 0 )
			{
				return this;
			}
			var m:Matrix2 = newRotate( r );
			return concat( m );
		}
		
		/**
		 * Add a rotation about a point transformation to this matrix
		 * 
		 * @param r the rotation angle in radians
		 * @param p the point to rotate around
		 * 
		 * @return a reference to this matrix
		 */
		public function rotateAboutPoint( r:Number, p:Vector2 ):Matrix2
		{
			if( r == 0 )
			{
				return this;
			}
			var m:Matrix2 = newRotateAboutPoint( r, p );
			return concat( m );
		}

		/**
		 * The determinant of the matrix
		 */
		public function get determinant():Number
		{
			return a * d - b * c;
		}
		
		/**
		 * Get the inverse of this matrix
		 * 
		 * @return the inverse of this matrix, or null if no inverse exists
		 */
		public function inverse():Matrix2
		{
			return clone().invert();
		}
	
		/**
		 * Invert this matrix
		 * 
		 * @return a reference to this matrix or null if no inverse exists
		 */
		public function invert():Matrix2
		{
			if( determinant == 0 )
			{
				a = undefined;
				b = undefined;
				c = undefined;
				d = undefined;
				tx = undefined;
				ty = undefined;
				return null;
			}
			var det:Number = 1/determinant;
			var ma:Number = a;
			var mb:Number = b;
			var mc:Number = c;
			var md:Number = d;
			var mx:Number = tx;
			var my:Number = ty;
			a = md * det;
			b = -mb * det;
			c = -mc * det;
			d = ma * det;
			tx = ( mc * my - mx * md ) * det;
			ty = ( mx * mb - ma * my ) * det;
			return this;
		}
	
		/**
		 * Transform a point using this matrix
		 * 
		 * @param v the point to transform
		 * 
		 * @return the result of the transformation
		 */
		public function transformPoint( v:Vector2 ):Vector2
		{
			return new Vector2( a * v.x + c * v.y + tx, b * v.x + d * v.y + ty );
		}
		/**
		 * Transform a vector using this matrix. When vectors are transformed
		 * the translation elements tx and ty are ignored.
		 * 
		 * @param v the vector to transform
		 * 
		 * @return the result of the transformation
		 */
		public function transformVector( v:Vector2 ):Vector2
		{
			return new Vector2( a * v.x + c * v.y, b * v.x + d * v.y );
		}
		/**
		 * Transform an array of points using this matrix. The points themseles
		 * are altered so the array contains the new values.
		 * 
		 * @param v the array of points to transform.
		 */
		public function transformArrayPoints( v:Array ):void
		{
			v.forEach( transformArrayPoint );
		}
		/**
		 * Transform an array of vectors using this matrix. When transforming 
		 * vectors, the translation elements tx and ty are ignored. The vectors
		 * themselves are altered so the array contains the new values
		 * 
		 * @param v the array of vectors to transform.
		 */
		public function transformArrayVectors( v:Array ):void
		{
			v.forEach( transformArrayVector );
		}
		
		private function transformArrayPoint( v:Vector2, i:int, ar:Array ):void
		{
			var x:Number = v.x;
			var y:Number = v.y;
			v.x = a * x + c * y + tx;
			v.y = b * x + d * y + ty;
		}
		private function transformArrayVector( v:Vector2, i:int, ar:Array ):void
		{
			var x:Number = v.x;
			var y:Number = v.y;
			v.x = a * x + c * y;
			v.y = b * x + d * y;
		}
	
		/**
		 * String representation for debugging purposes
		 */
		public function toString():String
		{
			return "(a=" + a + ", b=" + b + ", c=" + c + ", d=" + d + ", tx=" + tx + ", ty=" + ty + ")";
		}

	}
}
