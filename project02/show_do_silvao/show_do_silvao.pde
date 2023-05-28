import ddf.minim.*;

Minim minim;
TelaPerguntas telaPerguntas;

void setup()
{
   fullScreen();
   frameRate(30);

   minim = new Minim(this);
   telaPerguntas = new TelaPerguntas();
}

void draw()
{
   telaPerguntas.exibir();
}

void mouseClicked()
{
   Mouse.clique();
}
