import Test.Hspec
import Algorithm

main :: IO ()
main = hspec $ do
  describe "findSecretWord" $ do
    it "Should find secret word in row" $ do
      (findSecretWord ["sekrhaskelletnetestslowo"] ["haskell", "test"]) 'shouldBe' "sekretneslowo"
