import ddf.minim.*;

public class TelaPerguntas
{
   public final String _ARQUIVO_PERGUNTAS_XML = "perguntas.xml";
   private PerguntasXml _perguntasXml;

   public final String _ARQUIVO_SOM_RESPOSTA_CERTA = "certa_resposta.mp3";
   private AudioPlayer _somRespostaCerta;
   public final String _ARQUIVO_SOM_RESPOSTA_ERRADA = "errou.mp3";
   private AudioPlayer _somRespostaErrada;
   public final String _ARQUIVO_SOM_TEMPO_FINALIZADO = "ta_bom.mp3";
   private AudioPlayer _somTempoFinalizado;

   public final String _ARQUIVO_IMAGEM_FUNDO = "silvioS2.jpg";
   private PImage _imagem_fundo;

   public final int _PONTOS_ACERTO = 1;
   public final int _PONTOS_ERRO = -2;
   private Pontuacao _pontuacao;

   public final int _DURACAO_JOGO_SEGUNDOS = 60;
   private Temporizador _temporizador;

   public final int _ACERTOS_CONSECUTIVOS_PARA_BONUS_SEGUNDOS = 3;
   public final int _DURACAO_EM_MILISEGUNDOS_EXIBICAO_BONUS_SEGUNDOS = 500;
   public final int _SEGUNDOS_DE_BONUS = 7;
   private BonusSegundos _bonusSegundos;
   private int _acertosConsecutivos = 0;

   private Enunciado _enunciado;
   private Alternativa[] _alternativas;
   private int _alternativaCerta;

   public TelaPerguntas()
   {
      _somRespostaCerta = minim.loadFile(_ARQUIVO_SOM_RESPOSTA_CERTA);
      _somRespostaErrada = minim.loadFile(_ARQUIVO_SOM_RESPOSTA_ERRADA);
      _somTempoFinalizado = minim.loadFile(_ARQUIVO_SOM_TEMPO_FINALIZADO);

      _imagem_fundo = loadImage(_ARQUIVO_IMAGEM_FUNDO);
      _imagem_fundo.resize(width, height);

      _pontuacao = new Pontuacao();

      _temporizador = new Temporizador(_DURACAO_JOGO_SEGUNDOS);

      _bonusSegundos = new BonusSegundos(_SEGUNDOS_DE_BONUS,
                                         _DURACAO_EM_MILISEGUNDOS_EXIBICAO_BONUS_SEGUNDOS);

      _perguntasXml = new PerguntasXml(_ARQUIVO_PERGUNTAS_XML);
      carregarProximaPergunta();
   }

   private void carregarProximaPergunta()
   {
      _perguntasXml.selecionarPerguntaAleatoria();

      _enunciado = new Enunciado(_perguntasXml.getEnunciado());

      _alternativas = new Alternativa[_perguntasXml.getAlternativasLength()];
      float yAlternativa = _enunciado._Y + (_enunciado._ALTURA * 1.5);
      for (int i = 0; i < _alternativas.length; ++i)
      {
         _alternativas[i] = new Alternativa(_perguntasXml.getAlternativa(i), yAlternativa);
         yAlternativa += _alternativas[i]._ALTURA * 1.5;
      }

      _alternativaCerta = _perguntasXml.getResposta();
   }

   public void exibir()
   {
      final float GROSSURA_CONTORNO = 5;
      strokeWeight(GROSSURA_CONTORNO);
      final color COR_CONTORNO = #000000;
      stroke(COR_CONTORNO);

      background(_imagem_fundo);

      _enunciado.exibir();

      for (int i = 0; i < _alternativas.length; ++i)
      {
         _alternativas[i].exibir();
         if (_alternativas[i].mousePorCima() && Mouse.clicou())
         {
            if (i == _alternativaCerta)
            {
               _somRespostaCerta.play();
               _somRespostaCerta.rewind();
               _pontuacao.somarPontuacao(_PONTOS_ACERTO);

               ++_acertosConsecutivos;
               if (_acertosConsecutivos >= _ACERTOS_CONSECUTIVOS_PARA_BONUS_SEGUNDOS)
               {
                  // adiciona pontos extras pela sequência de acertos
                  _pontuacao.somarPontuacao(_PONTOS_ACERTO);
                  // adiciona tempo extra pela sequência de acertos
                  _temporizador.adicinarSegundos(_bonusSegundos.getSegundos());

                  _bonusSegundos.setMilisegundosInicioExibicao(millis());
               }
            }
            else
            {
               _somRespostaErrada.play();
               _somRespostaErrada.rewind();
               _pontuacao.somarPontuacao(_PONTOS_ERRO);
               _acertosConsecutivos = 0;
            }
            carregarProximaPergunta();
         }
      }

      if (_bonusSegundos.deveExibir())
      {
         _bonusSegundos.exibir();
      }

      _pontuacao.exibir();

      _temporizador.exibir();
      _temporizador.contarRegressivo();

      // acabou o tempo?
      if (_temporizador.getSegundos() <= 0)
      {
         _somTempoFinalizado.play();
         _somTempoFinalizado.rewind();
         delay(3000);
         exit();
      }
   }
}
