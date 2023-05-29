private class Enunciado
{
   private String _texto;
   public final int _CARACTERES_POR_LINHA = 100;

   public final float _X = 0;
   public final float _Y = height * 0.015;
   public final float _LARGURA = width * 0.8;
   public final float _ALTURA = height * 0.175;
   public final float _ARREDONDAMENTO_CANTO = (width + height) * 0.005;
   public final color _COR_FUNDO = #E0B41632;
   public final color _COR_CONTORNO = #000000;

   public final color _COR_TEXTO = #FFFFFF;
   public final float _TAMANHO_TEXTO = (width + height) * 0.02;
   public final int _ALINHAMENTO_HORIZONTAL_TEXTO = CENTER;
   public final int _ALINHAMENTO_VERTICAL_TEXTO = CENTER;

   public Enunciado(String texto)
   {
      if (texto.length() > _CARACTERES_POR_LINHA)
      {
         _texto = texto.substring(0, _CARACTERES_POR_LINHA) + "\n" + texto.substring(_CARACTERES_POR_LINHA);
      }
      else
      {
         _texto = texto;
      }
   }

   public void exibir()
   {
      fill(_COR_FUNDO);
      stroke(_COR_CONTORNO);
      rect(_X, _Y, _LARGURA, _ALTURA, _ARREDONDAMENTO_CANTO);

      fill(_COR_TEXTO);
      textSize(_TAMANHO_TEXTO);
      textAlign(_ALINHAMENTO_HORIZONTAL_TEXTO, _ALINHAMENTO_VERTICAL_TEXTO);
      text(_texto, _X, _Y, _LARGURA, _ALTURA);
   }
}

private class Alternativa
{
   private String _texto;
   private float _y;
   public final int _CARACTERES_POR_LINHA = 100;

   public final float _X = 0;
   public final float _LARGURA = width * 0.4;
   public final float _ALTURA = height * 0.11;
   public final float _ARREDONDAMENTO_CANTO = (width + height) * 0.005;
   public final color _COR_FUNDO_SEM_MOUSE = #E0B41632;
   public final color _COR_FUNDO_COM_MOUSE = #E03216B4;
   public final color _COR_CONTORNO_SEM_MOUSE = #000000;
   public final color _COR_CONTORNO_COM_MOUSE = #FFFFFF;

   public final color _COR_TEXTO = #FFFFFF;
   public final float _TAMANHO_TEXTO = (width + height) * 0.0135;
   public final int _ALINHAMENTO_HORIZONTAL_TEXTO = CENTER;
   public final int _ALINHAMENTO_VERTICAL_TEXTO = CENTER;

   public Alternativa(String texto, float y)
   {
      if (texto.length() > _CARACTERES_POR_LINHA)
      {
         _texto = texto.substring(0, _CARACTERES_POR_LINHA) + "\n" + texto.substring(_CARACTERES_POR_LINHA);
      }
      else
      {
         _texto = texto;
      }

      _y = y;
   }

   public float getY()
   {
      return _y;
   }

   public boolean mousePorCima()
   {
      return (mouseX > _X) && (mouseX < _X + _LARGURA) &&
             (mouseY > _y) && (mouseY < _y + _ALTURA);
   }

   public void exibir()
   {
      if (mousePorCima())
      {
         fill(_COR_FUNDO_COM_MOUSE);
         stroke(_COR_CONTORNO_COM_MOUSE);
      }
      else
      {
         fill(_COR_FUNDO_SEM_MOUSE);
         stroke(_COR_CONTORNO_SEM_MOUSE);
      }
      rect(_X, _y, _LARGURA, _ALTURA, _ARREDONDAMENTO_CANTO);

      fill(_COR_TEXTO);
      textSize(_TAMANHO_TEXTO);
      textAlign(_ALINHAMENTO_HORIZONTAL_TEXTO, _ALINHAMENTO_VERTICAL_TEXTO);
      text(_texto, _X, _y, _LARGURA, _ALTURA);
   }
}

private class Pontuacao
{
   private int _pontuacao;

   public final float _X = width * 0.65;
   public final float _Y = height * 0.4;
   public final float _LARGURA = (width + height) * 0.2;
   public final float _ALTURA = (width + height) * 0.2;
   public final float _ARREDONDAMENTO_CANTO = (width + height) * 0.02;
   public final color _COR_FUNDO = #50000000;

   public final color _COR_PONTUACAO_NEGATIVA = #BB0000;
   public final color _COR_POTUACAO_POSITIVA = #00BB00;
   public final float _TAMANHO_TEXTO = (width + height) * 0.15;
   public final int _ALINHAMENTO_HORIZONTAL_TEXTO = CENTER;
   public final int _ALINHAMENTO_VERTICAL_TEXTO = TOP;

   public Pontuacao()
   {
      _pontuacao = 0;
   }

   public Pontuacao(int pontosIniciais)
   {
      _pontuacao = pontosIniciais;
   }

   public void somarPontuacao(int pontos)
   {
      _pontuacao += pontos;
   }

   public void exibir()
   {
      color corPontuacao = (_pontuacao < 0) ? _COR_PONTUACAO_NEGATIVA : _COR_POTUACAO_POSITIVA;

      fill(_COR_FUNDO);
      stroke(corPontuacao);
      rect(_X, _Y, _LARGURA, _ALTURA, _ARREDONDAMENTO_CANTO);

      final int PONTUACAO_MINIMA_LIMITE = -100;
      fill(corPontuacao);
      textSize(_TAMANHO_TEXTO);
      textAlign(_ALINHAMENTO_HORIZONTAL_TEXTO, _ALINHAMENTO_VERTICAL_TEXTO);
      if (_pontuacao > PONTUACAO_MINIMA_LIMITE)
      {
         text(str(_pontuacao), _X, _Y, _LARGURA, _ALTURA);
      }
      else
      {
         text("aff", _X, _Y, _LARGURA, _ALTURA);
      }
   }
}

private class Temporizador
{
   private float _segundos;

   public final float _X = width * 0.9;
   public final float _Y = 0;

   public final color _COR_SEGUNDOS_COMECO = #00FF00;

   public final color _COR_SEGUNDOS_MEIO = #FFFF00;
   private float _segundosMeio;

   public final color _COR_SEGUNDOS_FIM = #FF0000;
   private float _segundosFim;

   public final float _TAMANHO_TEXTO = (width + height) * 0.07;
   public final int _ALINHAMENTO_HORIZONTAL_TEXTO = CENTER;
   public final int _ALINHAMENTO_VERTICAL_TEXTO = TOP;

   public Temporizador(float segundosInicio)
   {
      _segundos = segundosInicio;
      _segundosMeio = _segundos * 0.5;
      _segundosFim = _segundos * 0.2;
   }

   private float getSegundos()
   {
      return _segundos;
   }

   private void contarRegressivo()
   {
      _segundos -= 1 / frameRate;
   }

   public void adicinarSegundos(float segundos)
   {
      _segundos += segundos;
   }

   public void exibir()
   {
      color corSegundos;
      if (_segundos > _segundosMeio)
      {
         corSegundos = _COR_SEGUNDOS_COMECO;
      }
      else if (_segundos > _segundosFim)
      {
         corSegundos = _COR_SEGUNDOS_MEIO;
      }
      else
      {
         corSegundos = _COR_SEGUNDOS_FIM;
      }

      fill(corSegundos);
      textSize(_TAMANHO_TEXTO);
      textAlign(_ALINHAMENTO_HORIZONTAL_TEXTO, _ALINHAMENTO_VERTICAL_TEXTO);
      text(str(int(_segundos)), _X, _Y);
   }
}

private class BonusSegundos
{
   private int _segundos;
   private int _milisegundosInicioExibicao = 0;
   private int _duracaoExibicaoMilisegundos;

   public final float _X = width * 0.9;
   public final float _Y = height * 0.15;

   public final color _COR_TEXTO = #00FF00;
   public final float _TAMANHO_TEXTO = (width + height) * 0.07;
   public final int _ALINHAMENTO_HORIZONTAL_TEXTO = CENTER;
   public final int _ALINHAMENTO_VERTICAL_TEXTO = TOP;

   public BonusSegundos(int segundos, int duracaoExibicaoMilisegundos)
   {
      _segundos = segundos;
      _duracaoExibicaoMilisegundos = duracaoExibicaoMilisegundos;
   }

   public int getSegundos()
   {
      return _segundos;
   }

   public void setMilisegundosInicioExibicao(int milisegundos)
   {
      _milisegundosInicioExibicao = milisegundos;
   }

   public boolean deveExibir()
   {
      return (millis() - _milisegundosInicioExibicao) < _duracaoExibicaoMilisegundos;
   }

   public void exibir()
   {
      fill(_COR_TEXTO);
      textSize(_TAMANHO_TEXTO);
      textAlign(_ALINHAMENTO_HORIZONTAL_TEXTO, _ALINHAMENTO_VERTICAL_TEXTO);
      text("+" + str(_segundos), _X, _Y);
   }
}
