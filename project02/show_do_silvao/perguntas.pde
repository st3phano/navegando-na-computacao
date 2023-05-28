private class PerguntasXml
{
   private XML _xml;
   private XML[] _perguntas;
   private int _perguntaAtual;
   private IntList _ordemPerguntas;

   public final String _TAG_PERGUNTA = "pergunta";
   public final String _TAG_ENUNCIADO = "enunciado";
   public final String _TAG_ALTERNATIVAS = "alternativas";
   public final String _TAG_ALTERNATIVA = "alternativa";
   public final String _TAG_RESPOSTA = "resposta";

   public PerguntasXml(String arquivoXml)
   {
      _xml = loadXML(arquivoXml);
      _perguntas = _xml.getChildren(_TAG_PERGUNTA);
      embaralharOrdemPerguntas();
   }

   private void embaralharOrdemPerguntas()
   {
      _ordemPerguntas = new IntList();
      for (int i = 0; i < _perguntas.length; ++i)
      {
         _ordemPerguntas.append(i);
      }
      _ordemPerguntas.shuffle();
   }

   public void selecionarPerguntaAleatoria()
   {
      if (_ordemPerguntas.size() == 0)
      {
         embaralharOrdemPerguntas();
      }

      _perguntaAtual = _ordemPerguntas.get(0);
      _ordemPerguntas.remove(0);
   }

   public String getEnunciado()
   {
      return _perguntas[_perguntaAtual].getChild(_TAG_ENUNCIADO).getContent();
   }

   public int getAlternativasLength()
   {
      return _perguntas[_perguntaAtual].getChild(_TAG_ALTERNATIVAS).getChildren(_TAG_ALTERNATIVA).length;
   }

   public String[] getAlternativas()
   {
      XML[] alternativasXml = _perguntas[_perguntaAtual].getChild(_TAG_ALTERNATIVAS).getChildren(_TAG_ALTERNATIVA);
      String[] alternativasString= new String[alternativasXml.length];
      for (int i = 0; i < alternativasString.length; ++i)
      {
         alternativasString[i] = alternativasXml[i].getContent();
      }

      return alternativasString;
   }

   public String getAlternativa(int indice)
   {
      XML[] alternativas = _perguntas[_perguntaAtual].getChild(_TAG_ALTERNATIVAS).getChildren(_TAG_ALTERNATIVA);
      return alternativas[indice].getContent();
   }

   public int getResposta()
   {
      return _perguntas[_perguntaAtual].getChild(_TAG_RESPOSTA).getIntContent();
   }
}
