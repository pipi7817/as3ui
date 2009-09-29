/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*
* Original sources:
* Zeh Fernando 
* http://zehfernando.com/2009/creating-a-movieclip-class-for-designers/
* 
* Mario Klingemann
* http://www.graficaobscura.com/matrix/index.html
* http://www.quasimondo.com/archives/000565.php
* http://www.quasimondo.com/colormatrix/ColorMatrix.as
* http://www.quasimondo.com
* Licensed under MIT license:
* http://www.opensource.org/licenses/mit-license.php
*/

package as3ui.display
{
	import flash.filters.ColorMatrixFilter;
	

	public class AnimatedSprite extends UIComponent
	{

		// Defines luminance using sRGB luminance
		protected static const LUMINANCE_R:Number = 0.212671;
		protected static const LUMINANCE_G:Number = 0.715160;
		protected static const LUMINANCE_B:Number = 0.072169;
  
		// Color properties
		protected var m_saturation:Number;	// Saturation: 0 (grayscale) -> 1 (normal, default) -> 2+ (highly saturated)
		protected var m_contrast:Number;	// Contrast: 0 (grey) -> 1 (normal) -> 2 (high contrast)
		protected var m_brightness:Number;	// Brightness offset: -1 (black) -> 0 (normal) -> 1 (full white)
		protected var m_exposure:Number;	// Brightness multiplier: 0 (black) -> 1 (normal) -> 2 (super bright)
		protected var m_hue:Number;			// Hue offset in degrees: -180 -> 0 (normal) -> 180 
		protected var m_color:uint;			// Color: 0x000000 (black) -> 0xFFFFFF (white).
		protected var m_colorization:Number;// Amount of color to add: 0 (normal) -> 1 (full color)

		// Color transform matrices
		protected var saturationMatrix:Array;
		protected var contrastMatrix:Array;
		protected var brightnessMatrix:Array;
		protected var exposureMatrix:Array;
		protected var hueMatrix:Array;
  		protected var colorizeMatrix:Array;
  		
		// Instance propertes
  		protected var m_filters:Array;
  		
		public function AnimatedSprite(a_init:Object = null)
		{
			super();
			if(a_init)
			{
				filters = [];
				saturation = a_init.saturation?a_init.saturation:1;
				contrast = a_init.contrast?a_init.contrast:1;
				brightness =a_init.brightness?a_init.brightness:0;
				exposure = a_init.exposure?a_init.exposure:1;
				colorization = a_init.colorization?a_init.colorization:0;
				color = a_init.color?a_init.color:0;
				hue = a_init.hue?a_init.hue:0;				
			}
			else
			{
				filters = [];
				saturation = 1;
				contrast = 1;
				brightness = 0;
				exposure = 1;
				colorization = 0;
				hue = 0;
			}
		}


		protected function updateSaturationMatrix(): void {
			var nc:Number = 1-m_saturation;
			var nr:Number = LUMINANCE_R * nc;
			var ng:Number = LUMINANCE_G * nc;
			var nb:Number = LUMINANCE_B * nc;
		
			saturationMatrix = [
								nr+m_saturation,ng,nb,0,0,
								nr,ng+m_saturation,nb,0,0,
								nr,ng,nb+m_saturation,0,0,
								0,0,0,1,0
								];
			setChanged();
		}

		protected function updateContrastMatrix(): void {
			var co:Number = 128 * (1-m_contrast);
			contrastMatrix = [
			m_contrast, 0, 0,  0,  co,
			0, m_contrast, 0,  0,  co,
			0, 0, m_contrast,  0,  co,
			0, 0, 0,  1,  0
			];
			setChanged();
		}

		protected function updateBrightnessMatrix(): void {
			var co:Number = 255 * m_brightness;
			brightnessMatrix = [
			1, 0, 0,  0,  co,
			0, 1, 0,  0,  co,
			0, 0, 1,  0,  co,
			0, 0, 0,  1,  0
			];
			setChanged();
		}

		protected function updateExposureMatrix(): void {
			exposureMatrix = [
			m_exposure, 0, 0,  0,  0,
			0, m_exposure, 0,  0,  0,
			0, 0, m_exposure,  0,  0,
			0, 0, 0,  1,  0
			];
			setChanged();
		}

		protected function updateHueMatrix(): void
		{
			var hAngle:Number = m_hue / 180 * Math.PI;
			var hCos:Number = Math.cos(hAngle);
			var hSin:Number = Math.sin(hAngle);
			
			hueMatrix = [
			((LUMINANCE_R + (hCos * (1 - LUMINANCE_R))) + (hSin * -(LUMINANCE_R))), ((LUMINANCE_G + (hCos * -(LUMINANCE_G))) + (hSin * -(LUMINANCE_G))), ((LUMINANCE_B + (hCos * -(LUMINANCE_B))) + (hSin * (1 - LUMINANCE_B))), 0, 0,
			((LUMINANCE_R + (hCos * -(LUMINANCE_R))) + (hSin * 0.143)), ((LUMINANCE_G + (hCos * (1 - LUMINANCE_G))) + (hSin * 0.14)), ((LUMINANCE_B + (hCos * -(LUMINANCE_B))) + (hSin * -0.283)), 0, 0,
			((LUMINANCE_R + (hCos * -(LUMINANCE_R))) + (hSin * -((1 - LUMINANCE_R)))), ((LUMINANCE_G + (hCos * -(LUMINANCE_G))) + (hSin * LUMINANCE_G)), ((LUMINANCE_B + (hCos * (1 - LUMINANCE_B))) + (hSin * LUMINANCE_B)), 0, 0,
			0, 0, 0, 1, 0
			];
			setChanged();
		}
		
		protected function updateColorizeMatrix(): void
		{
			var amount:Number = m_colorization;
			
			var r:Number = ((color >> 16) & 0xff) / 255;
			var g:Number = ((color >> 8)  & 0xff) / 255;
			var b:Number = (color         & 0xff) / 255;
			var inv:Number = 1 - amount;

			colorizeMatrix = [inv + amount * r * LUMINANCE_R, amount * r * LUMINANCE_G, amount * r * LUMINANCE_B, 0, 0,
							  amount * g * LUMINANCE_R, inv + amount * g * LUMINANCE_G, amount * g * LUMINANCE_B, 0, 0,
							  amount * b * LUMINANCE_R, amount * b * LUMINANCE_G, inv + amount * b * LUMINANCE_B, 0, 0,
							  0, 0, 0, 1, 0];
							  
			setChanged();
		}
		

		override protected function draw(): void 
		{
			super.draw();
			var mtx:Array = [
							1,0,0,0,0,
							0,1,0,0,0,
							0,0,1,0,0,
							0,0,0,1,0
							];

			var temp:Array = [];

			// Precalculate a single matrix from all matrices by multiplication
			// The order the final matrix is calculated can change the way it looks
			var matrices:Array = [saturationMatrix, contrastMatrix, brightnessMatrix, exposureMatrix, hueMatrix, colorizeMatrix];
			
			var i:int, j:int, mat:Array;
			var x:int, y:int;
			
			for (j = 0; j < matrices.length; j++)
			{
				i = 0;
				mat = matrices[j];

				for (y = 0; y < 4; y++ )
				{
					for (x = 0; x < 5; x++ )
					{
						temp[ int( i + x) ] =	Number(mat[i  ])      * Number(mtx[x]) +
												Number(mat[int(i+1)]) * Number(mtx[int(x +  5)]) +
												Number(mat[int(i+2)]) * Number(mtx[int(x + 10)]) +
												Number(mat[int(i+3)]) * Number(mtx[int(x + 15)]) +
												(x == 4 ? Number(mat[int(i+4)]) : 0);
					}
					i+=5;
				}
				mtx = temp;
			}

			var newFilters:Array = [new ColorMatrixFilter(mtx)];
			super.filters = newFilters.concat(m_filters);
		}


		//////////////////////////////////////////////////////////////////
		// PUBLIC ACCESSOR's
		//////////////////////////////////////////////////////////////////
		public function get saturation(): Number
		{
			return m_saturation;
		}

		public function set saturation(a_value:Number): void
		{
			m_saturation = a_value;
			updateSaturationMatrix();
		}
		
		public function get contrast(): Number
		{
			return m_contrast;
		}

		public function set contrast(a_value:Number): void
		{
			m_contrast = a_value;
			updateContrastMatrix();
		}
		
		public function get brightness(): Number
		{
			return m_brightness;
		}

		public function set brightness(a_value:Number): void
		{
			m_brightness = a_value;
			updateBrightnessMatrix();
		}
		
		public function get exposure(): Number
		{
			return m_exposure;
		}

		public function set exposure(a_value:Number): void 
		{
			m_exposure = a_value;
			updateExposureMatrix();
		}
		
		public function get hue(): Number
		{
			return m_hue;
		}

		public function set hue(a_value:Number): void
		{
			m_hue = a_value;
			updateHueMatrix();
		}
		
		override public function get filters(): Array
		{
			return m_filters;
		}
	
		override public function set filters(a_value:Array): void
		{
			m_filters = a_value;
			setChanged();
		}		

		public function get color(): Number
		{
			return m_color;
		}
	
		public function set color(a_value:Number): void
		{
			m_color = a_value;
			updateColorizeMatrix();
		}

		public function get colorization(): Number
		{
			return m_colorization;
		}
		
		public function set colorization(a_value:Number): void
		{
			m_colorization = a_value;
			updateColorizeMatrix();
		}

	}
}