/*
一番最初に使ったDoファイルです。

ちなみに複数行のコメントはこうやって書きます。（色が緑になります。）
*/


* 保存されているデータなどを全て消去する
clear all

* logファイル（Stataのアウトプットが保存されているファイル）を閉じる
capture log close

* Working Directory（Doファイルやデータセットが入っているフォルダ）に移動する（人によって違います！）
cd "/Users/akirasato/Docs/stata_introduction/May7/do_files_etc"

/*
Stataの結果が全て保存されるlogファイルを作成する（stataoutput.smclというファイル名）
replaceはファイルがない場合は新規作成，ある場合は上書きすることを表します。
*/
log using stataoutput, replace

* 使うデータセットをダウンロードする
* 途中から緑になってるけど，大丈夫。
use http://fmwww.bc.edu/ec-p/data/wooldridge/gpa2


* -------------------- 一旦ここで止めてデータEditorを見てみましょう ------------------

* データの概要を表示する（sumでも大丈夫）
summarize


* ヒストグラムを表示する
hist sat
* 保存しましょう（pngで）
graph export hist1.png, replace


* 散布図を表示する
scatter colgpa sat
* 保存しましょう（今度は...jpgで）
graph export scat1.jpg, replace


* ------------------------------------------------------------------------------


reg colgpa sat, r

reg colgpa sat hsize, r

