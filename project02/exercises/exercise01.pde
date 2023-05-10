final int CANVAS_SIDE = 600;

final float RADIUS_LATERAL_CIRCLE = 25;
final float DIAMETER_LATERAL_CIRCLE = 2 * RADIUS_LATERAL_CIRCLE;
final float RADIUS_CENTRAL_CIRCLE = CANVAS_SIDE - (3 * RADIUS_LATERAL_CIRCLE);

void settings()
{
   size(CANVAS_SIDE, CANVAS_SIDE);
}   

void setup()
{
   frameRate(5);
}

void draw()
{
   for (float xy = RADIUS_LATERAL_CIRCLE; xy < CANVAS_SIDE; xy += DIAMETER_LATERAL_CIRCLE)
   {
      drawBlinkingCircle(RADIUS_LATERAL_CIRCLE, xy, DIAMETER_LATERAL_CIRCLE); // left
      drawBlinkingCircle(CANVAS_SIDE - RADIUS_LATERAL_CIRCLE, xy, DIAMETER_LATERAL_CIRCLE); // right
      drawBlinkingCircle(xy, RADIUS_LATERAL_CIRCLE, DIAMETER_LATERAL_CIRCLE); // top
      drawBlinkingCircle(xy, CANVAS_SIDE - RADIUS_LATERAL_CIRCLE, DIAMETER_LATERAL_CIRCLE); // bottom

      drawBlinkingCircle(CANVAS_SIDE / 2, CANVAS_SIDE / 2, RADIUS_CENTRAL_CIRCLE - xy); // center      
   }
}

void drawBlinkingCircle(float x, float y, float diameter)
{
   fill(random(128, 255), random(128, 255), random(128, 255));
   circle(x, y, diameter);
}
