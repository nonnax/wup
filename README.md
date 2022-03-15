# wup is a cli-journal

## commands

## wup : input post

## wpull : pull a post

## wput : put post, (use: template)

~~~
  ex. wblank | $EDITOR | wput
~~~

## wed : edit

~~~
  ex. wed <key> or 
  echo <key> | wed
~~~

## wgrep : grep

~~~
  wgrep <q> or 
  echo <q> | wgrep

~~~

## wgrepz :  fzf query

## wkeys : list keys

## wls : list 

~~~
  ex. wls <any>

~~~

## wcat : cat 
~~~
  ex. wcat <key> or 
  echo <key> | wview

~~~
## wcatz : fzf view

## wrm : rm 

~~~
  ex. wrm <key> or 
  echo <key> | wrm

~~~

## wblank 

  ex. wblank | $EDITOR | wput

## template format 

~~~
    date: <date>
    tag: <tag>
    ---
    <post>
~~~
