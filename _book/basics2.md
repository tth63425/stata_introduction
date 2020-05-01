# Stataの基本的なコマンドの説明

```
/*
Doファイルの例
複数行のコメント
*/

* 1行のコメント

* 保存されているデータなどを全て消去する
clear all

* logファイル（Stataのアウトプットが保存されているファイル）を閉じる
capture log close

* Working Directory（Doファイルやデータセットが入っているフォルダ）に移動する（その都度異なります）
cd "/Users/akirasato/Docs/Okamuro_Seminar/stata_introduction"

/*
Stataの結果が全て保存されるlogファイルを作成する（stataoutput.logというファイル名）
replaceはファイルがない場合は新規作成，ある場合は上書きすることを表します。
*/
log using stataoutput, replace

* データセットをロードする
* 自分のPCにある"abcd.dta"というデータセット（Stataのデータセットの拡張子は.dtaです）を利用するためには"use abcd"とする
use http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1
```

上はStataでデータセットをロードするまでのDoファイルの一例です。`*`で始まる行，または`/* */`で挟まれた部分はコメントです。コメントが1行の時は`*`を，複数行にまたがる時は`/* */`を使います。

データセットがロードされると，Stataでエクセルと似た形式でデータを見ることができます。"Data"の部分をクリックしてみましょう。

![データを見る](https://user-images.githubusercontent.com/44024242/80774653-90de5080-8b98-11ea-94a5-a51bd9e46f67.png)

今回の例で使用しているデータセットはCEOの給料と企業の資本に関するデータです。3.1-3.9を参照して，コマンドを先ほどのDoファイルに追記して，コマンドを実行してみましょう。（なお，Doファイルの一部のみを実行する場合は，実行したいコマンドの範囲を選択してDoボタンを押します。）

なお，3.0から3.7までの全てのコマンドを記したDoファイルは以下のようになります。（コメントなし）

Doファイルの例：

```
clear all

capture log close

cd "/Users/akirasato/Docs/Okamuro_Seminar/stata_introduction"

log using stataoutput, replace

use http://fmwww.bc.edu/ec-p/data/wooldridge/ceosal1

display _N

desc salary
desc indus

tabulate indus finance

count if utility == 1

sum salary
sum salary sales

sum salary if indus == 1

hist salary

scatter salary sales

```
