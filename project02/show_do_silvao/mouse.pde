public static class Mouse
{
   private static boolean _clicou = false;
   
   public static void clique()
   {
      _clicou = true;
   }
   
   public static boolean clicou()
   {
      if (_clicou)
      {
         _clicou = false;
         return true;
      }

      return false;
   }
}
