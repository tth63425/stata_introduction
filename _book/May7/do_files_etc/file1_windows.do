/*
一番最初に使ったDoファイルです。

ちなみに複数行のコメントはこうやって書きます。（色が緑になります。）
*/


* 保存されているデータなどを全て消去する
clear all

* logファイル（Stataのアウトプットが保存されているファイル）を閉じる
capture log close

* Working Directory（Doファイルやデータセットが入っているフォルダ）に移動する（人によって違います！）
cd "C:\Users\SatoA\OneDrive\Documents\Okamuro Seminar"

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
* 保存しましょう
graph export scat1.png, replace


* ------------------------------------------------------------------------------


reg colgpa sat, r

reg colgpa sat hsize, r


* -----------------------------------------------------------------------------

reg colgpa sat, r

outreg2 using table1.doc, replace

reg colgpa sat hsize, r

outreg2 using table1.doc, append

* ------------------------------------------------------------------------------

reg colgpa sat, r
test sat
local F1 = r(F)
local P1 = r(p)
outreg2 using table2.doc, adds(F-value, `F1', p-value, `P1') replace

reg colgpa sat hsize, r
test sat
local F2 = r(F)
local P2 = r(p)
outreg2 using table2.doc, adds(F-value, `F2', p-value, `P2') append

* ------------------------------------------------------------------------------

