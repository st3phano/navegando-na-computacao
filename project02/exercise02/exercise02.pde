final int CANVAS_SIDE = 600;

final float CLICK_AREA_HEIGHT = CANVAS_SIDE / 10;

final float SQUARE_SIDE_VARIATION = CANVAS_SIDE / 50;
final float SQUARE_SIDE_MAX = CANVAS_SIDE - (CLICK_AREA_HEIGHT * 2);
float squareSide = SQUARE_SIDE_VARIATION;

void settings()
{
   size(CANVAS_SIDE, CANVAS_SIDE);
}

void setup()
{
   rectMode(CENTER);
   textAlign(CENTER, TOP);
   textSize(CANVAS_SIDE / 15);
}

void draw()
{
   background(255);

   text("+", CANVAS_SIDE / 2, CLICK_AREA_HEIGHT / 2, CANVAS_SIDE, CLICK_AREA_HEIGHT);
   text("-", CANVAS_SIDE / 2, CANVAS_SIDE - (CLICK_AREA_HEIGHT / 2), CANVAS_SIDE, CLICK_AREA_HEIGHT);

   // big gray rectangle in the center of the canvas
   fill(128);
   rect(CANVAS_SIDE / 2, CANVAS_SIDE / 2, CANVAS_SIDE, SQUARE_SIDE_MAX);

   // black square in the center of the canvas
   fill(0);
   square(CANVAS_SIDE / 2, CANVAS_SIDE / 2, squareSide);
}

void mouseClicked()
{
   // increase/decrease square size in the center of the canvas with mouse click
   if ((squareSide + SQUARE_SIDE_VARIATION < SQUARE_SIDE_MAX) && (mouseY < CLICK_AREA_HEIGHT))
   {
      squareSide += SQUARE_SIDE_VARIATION;
   }
   else if ((squareSide - SQUARE_SIDE_VARIATION > 0) && (mouseY > (height - CLICK_AREA_HEIGHT)))
   {
      squareSide -= SQUARE_SIDE_VARIATION;
   }
}
