
package bigroom.utils 
{
    import flash.utils.Dictionary;
	/**
	 * Class to create a weak reference to an object. A weak reference
	 * is a reference that does not prevent the object from being
	 * garbage collected. If the object has been garbage collected
	 * then the get method will return null.
	 */
    public class WeakRef
    {
        private var dic:Dictionary;
		
		/**
		 * The constructor - creates a weak reference.
		 * 
		 * @param obj the object to create a weak reference to
		 */
        public function WeakRef( obj:* )
        {
            dic = new Dictionary( true );
            dic[obj] = 1;
        }
		
		/**
		 * To get a strong reference to the object.
		 * 
		 * @return a strong reference to te object or null if the
		 * object has been garbage collected
		 */
        public function get():*
        {
            for( var item:* in dic )
            {
                return item;
            }
            return null;
        }
    }
}
