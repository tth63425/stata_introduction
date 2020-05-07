### はじめに
  
- 一応授業時間と同じ105分で終わるように頑張ります。（2時間は絶対に行かないようにします。）
- 途中退出，途中参加，自由です！
- もともと自分用に作っていたサイトなので，間違いやTypoが絶対どこかにあるはずです。遠慮なく指摘して欲しいです！（そのほうが皆も自分も勉強になると思うので！）
- 質問も遠慮なくお願いします！話している途中で遮っても大丈夫です！
- WindowsとMac両方用意しました。Zoomの名前かStataの背景色で区別できます。
  - Zoomの名前：Akira SatoとAkira Sato (Windows)
  - Stataの背景：黒がMac，白がWindows
- 今日のコードは[ここで](https://github.com/tth63425/stata_introduction/tree/master/May7)見ることができます。
- この仮ページは2,3日したら消すので，それ以降は[ここ](https://github.com/tth63425/stata_introduction/blob/master/may7.md)からみてください。
- Stataインストールしてありますか？

### 今日の流れ（たぶん）
基本的には，「画面共有でどのように操作するか見る→実際に自分でStataを打つ（→答え合わせ）」みたいな感じでいきます。このサイトの章立てとはちょっと順番で進めようと思っています。

#### 1. Stataユーザインターフェイスの説明

#### 2. Doファイルエディタを開いてDoファイルの説明

#### 3. 今日使うフォルダの作成とDoファイルの保存

#### 4. Doファイルの最初の部分を書いてみる

- 自分がいるべきディレクトリはどこ？
- ここで使うデータセット`use http://fmwww.bc.edu/ec-p/data/wooldridge/gpa2`
- データをダウンロードしたら一回開いてみてみましょう

Doファイルの例：
```
/*
一番最初に使ったDoファイルです。

ちなみに複数行のコメントはこうやって書きます。（色が緑になります。）
*/


* 保存されているデータなどを全て消去する
clear all

* logファイル（Stataのアウトプットが保存されているファイル）を閉じる
capture log close

* Working Directory（Doファイルやデータセットが入っているフォルダ）に移動する（人によって違います！）
cd "ディレクトリまでのパス"

/*
Stataの結果が全て保存されるlogファイルを作成する（stataoutput.smclというファイル名）
replaceはファイルがない場合は新規作成，ある場合は上書きすることを表します。
*/
log using stataoutput, replace

* 使うデータセットをダウンロードする
* 途中から緑になってるけど，大丈夫。
use http://fmwww.bc.edu/ec-p/data/wooldridge/gpa2
```


データの概要（使う変数だけ）：

| 変数名               | 変数の説明                   |
|----------------------|------------------------------|
| 被説明変数：`colGPA` | 大学でのGPA                  |
| 説明変数1：`sat`     | アメリカ版センター試験の点数 |
| 説明変数2：`hsize`   | いた高校のクラスの生徒数 （かける100すると実際の人数）    |



- 試しにいくつかコマンド書いてみましょう（Doファイルの保存・一部のみ実行）
 - 何人分のデータがありますか？（おご）
 - SATの平均点どのくらいですか？（いり）
 - 高校のサイズの平均は？（かね）

#### 5. データの概要とかヒストグラムとか

Doファイルの続き：
```
* データの概要を表示する（sumでも大丈夫）
summarize


* ヒストグラムを表示する
hist sat
* 保存しましょう（pngで）
graph export hist1.png


* 散布図を表示する
scatter colgpa sat
* 保存しましょう（今度は...jpgで）
graph export scat1.jpg
```
ちゃんと画像が保存されているか確認してみる！

質問：
- SATの点数のヒストグラムを見てどんな感じ？偏っていたりしますか？（こむ）
- SATの点数と大学でのGPAに関して散布図から何か言えそうなことはありますか？（さく）

#### 6. 回帰分析（やって意味のある分析とは限らない）

##### 6-1. 1つめの回帰分析
$$u_i$$は誤差項です！1つめの回帰分析は...

$$
\text{colgpa}_i = \beta_0 + \beta_1 \text{sat}_i + u_i
$$

Doファイルの続き：
```
* regress colgpa sat, robustでもOK
reg colgpa sat, r
```

（不均一分散にするかは議論あり？？）

質問：
- $$\text{sat}_i$$の回帰係数（$$\beta_1$$）は？その95%信頼区間は？（せの）
- $$\beta_1$$の標準偏差は？（はや）

##### 6-2. 2つめの回帰分析
2つめの回帰分析は...

$$
\text{colgpa}_i = \beta_0 + \beta_1 \text{sat}_i + \beta_2 \text{hsize}_i + u_i
$$

Doファイルの続き：

```
reg colgpa sat hsize, r
```

質問：
- 決定係数は？（ふく）
- $$p$$値どんな感じ？$$t$$値は？（みつ）


### ここまできたらDoファイルが保存されていることを確認して，一回Stataを閉じる。もう一回Stataを起動してDoファイルを最初から実行すると...

エラーがでます。

質問：
- このエラーの意味は？（おご）
- ファイルを消さずに，このエラーをなくすためにはどうすればいい？（これ分かったらめちゃすごい，でもDoファイルの中にヒントある！！）（いり）

エラーを修正してもう一回Doファイルを最初から実行してみましょう。

#### 7. Stataに使えるデータについて（`.dta`ファイルと`.csv`ファイル）

「ちゃんとした」`.dta`ファイルみてみましょう。

-------------------------------------------------

ここから先は時間があったら...（なので説明が雑になっている）

`outreg2`と回帰分析もう一回やるのどっちがいいですか？

[ここから](https://www.kaggle.com/dansbecker/aer-credit-card-data/download/DYG0lJkiXyrDQzIFwhNG%2Fversions%2FHjdoZXGWfpxE3eaaDoPR%2Ffiles%2FAER_credit_card_data.csv?datasetVersionNumber=1)データ[^*]をダウンロードする。保存場所気をつけてね！

データは保存するときにファイル名を変えていなければ
```
import delimited AER_credit_card_data.csv
```
でいけます。（csvファイルのときは`import delimited`を使います。）

回帰分析してみましょう。ヒストグラムや散布図も...





[^*] https://www.kaggle.com/dansbecker/aer-credit-card-data#AER_credit_card_data.csv