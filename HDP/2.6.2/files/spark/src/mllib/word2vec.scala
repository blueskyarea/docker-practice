import java.io.StringReader
import org.apache.spark.mllib.feature.{Word2Vec, Word2VecModel}
import org.apache.lucene.analysis.ja.JapaneseTokenizer
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute
import org.apache.lucene.analysis.ja.tokenattributes.BaseFormAttribute
import org.apache.lucene.analysis.ja.tokenattributes.PartOfSpeechAttribute
import org.apache.spark.mllib.linalg.Vectors

import scala.collection.mutable.ArrayBuffer

def tokenize(sentence: String): Seq[String] = {
  val word: ArrayBuffer[String] = new ArrayBuffer[String]()
  lazy val stream = new JapaneseTokenizer(
    new StringReader(sentence),
    null,
    false,
    JapaneseTokenizer.Mode.NORMAL)

  try {
    while(stream.incrementToken()) {
      var charAtt = stream.getAttribute(
        classOf[CharTermAttribute]
      ).toString

      var bfAtt = stream.getAttribute(
        classOf[BaseFormAttribute]
      ).getBaseForm

      var partOfSpeech = stream.getAttribute(
        classOf[PartOfSpeechAttribute]
      ).getPartOfSpeech().split("-")(0)

      (partOfSpeech, bfAtt) match {
        case ("名詞", _)  => word += charAtt
        case ("動詞", null)  => word += charAtt
        case ("動詞", baseForm)  => word += baseForm
        case (_, _)  =>
      }
    }
  } finally {
    stream.close
  }
  word.toSeq
}

