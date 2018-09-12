gulp-static-website-v6
===============================

静的サイト制作用の汎用gulpタスクテンプレートです。

node.js v10.10.0で動作確認済み

gulp v3.9.1で動作確認済み

## install
```bash
mkdir yourProject
cd yourProject
git clone git@github.com:takumi0125/gulp-static-website-v5.git .
npm i
npm start
```


## 概要

`gulp` コマンドで `src/` の中身がタスクで処理され、ディレクトリ構造を保ちつつ `htdocs/` に展開されます。ただし、「 \_ (アンダースコア) 」で始まるファイルやディレクトリはコンパイル・コピーの対象外です。スプライト用のソース画像を格納するディレクトリや、Sassで@import するファイルは「 \_ (アンダースコア) 」をつけておけば、 `htdocs/` に展開されることはありません。

`npm start` コマンドでローカルサーバが立ち上がります。実行中は
```
http://localhost:50000/
```
で展開後のページが確認できます。

`pugData.coffee` は pug (jade) タスクを実行する際に読み込まれます。


gulp の各タスクは `gulp/tasks/` に格納してあります。このファイルはあまり変更することはないと思われます。

gulp の各種設定は `gulp/config.coffee` に定義してあります。プロジェクトごとに適宜変更してお使いください。


## コマンド

詳しくはpackage.jsonを参照

主に
```
npm start
```

```
npm run build
```

```
npm run watch
```

の３つです。

startはbuild + watch
buildはgulpのてフォルトタスクを実行
watchはローカルサーバ+ファイル更新監視です。

下２つは引数を設定可能
```
npm run build:dev
npm run build:stg
npm run build:prd
```

```
npm run watch:dev
npm run watch:stg
npm run watch:prd
```


デフォルト(引数を指定しない場合)はdevとなります。
コマンド実行時に `src/assets/js/_env.js` が吐き出され、
その内容は引数に寄って異なるため、javascriptで環境による出し分けが可能です。
適宜requireして使用してください。

```
module.exports = {
  "env": "develop", // dev: develop, stg: staging, prd: productionとなる
  "siteUrl": "xxxxxxx" // pugData.coffeeのsiteUrlの値
}
```



## cleanタスクについて
デフォルトタスクを実行、または、

```
gulp clean
```

でクリーンタスクが実行されます。
クリーンタスクの対象ディレクトリは `gulp/config.coffee` の

```coffeescript
# clean対象のディレクトリ (除外したいパスがある場合にnode-globのシンタックスで指定)
clearDir: [ "/**/*" ]
```

このように指定してあります。対象は publishDir 以下となります。
除外したいディレクトリやファイルがある場合は、こちらに設定を追加してください。


## カスタムタスク生成関数

スプライト画像、webpack, jsのconcat, coffee scriptのconcatを使用する場合は、
`gulp/utils.coffee` に定義されている以下の関数を使用し、タスクを定義してください。
以下の関数を実行すると、watchタスクも同時に定義されます。

カスタムタスクは `gulp/customTasks.coffee` に記述してください


### utils.createSpritesTask

spritesmith のタスクを生成する関数です。

※ スプライト生成には <a href="https://github.com/twolfson/gulp.spritesmith" target="_blank"> gulp.spritesmith</a> を使用しています。<br>

**Params**

 - `taskName` **{Object}**: タスクを識別するための名前 すべてのタスク名と異なるものにする
 - `cssDir` **{String}**: ソース画像ディレクトリへのパス ( `config.srcDir` からの相対パス)
 - `imgDir` **{String}**: ソース CSS ディレクトリへのパス ( `config.srcDir` からの相対パス)
 - `outputImgName` **{String}**: CSS に記述される画像パス (相対パスの際に指定する)
 - `outputImgPath` **{String}**: 指定しなければ #{taskName}.png になる

```coffeescript
"#{config.srcDir}#{imgDir}/_#{taskName}/"
```
以下にソース画像を格納しておくと
```coffeescript
"#{config.srcDir}#{cssDir}/_#{taskName}.scss"
```
と
```coffeescript
"#{config.srcDir}#{imgDir}/#{outputImgName or taskName}.png"
```
が生成されます。



### utils.createWebpackJsTask
webpack のタスクを生成する関数です。coffee script, babel, glsl を使用できます。
また、Vueの単一ファイルコンポーネント(.vue)、React.jsのjsxフォーマット(.js, .jsx)にも対応しています。
それぞれHTML部分はpug, CSS部分はscss, sassでも記述可能です。
(ただし、externalsオプションににreact, react-dom, vueを指定しているので各自bundleするなりしてください。)

**Params**

 - `taskName` **{Object}**: タスクを識別するための名前 すべてのタスク名と異なるものにする
 - `entries` **{Array|String}**: webpack の entriesオプションに渡す node-glob のシンタックスで指定
 - `src` **{Array|String}**: entries を除いた全ソースファイル ( watch タスクで監視するため) node-glob のシンタックスで指定
 - `outputDir` **{String}**: 最終的に出力されるjsが格納されるディレクトリ
 - `outputFileName` **{String}**: 最終的に出力される js ファイル名(拡張子なし)


### utils.createJsConcatTask

javascriptのconcatタスクを生成する関数です。ソースは minify されます。

**Params**

 - `taskName` **{Object}**: タスクを識別するための名前 すべてのタスク名と異なるものにする
 - `src` **{Array|String}**: ソースパス node-glob のシンタックスで指定
 - `outputDir` **{String}**: 最終的に出力される js が格納されるディレクトリ
 - `outputFileName` **{String}**: 最終的に出力される js ファイル名(拡張子なし)


その他設定等は `gulp/config.coffee` を参照
