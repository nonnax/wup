# wup is a cli-journal
![image](https://img.shields.io/badge/contact-nonnax-blue)

## commands

## wup : new post

## wpull : pull post

## wput : post via template (headless)

~~~
  usage:
  wblank | $EDITOR | wput

  or 
  
  pipe using template below:
    date: <date>
    tag: <tag>
    ---
    <post>
~~~

## wed : edit by key

~~~
  usage:
    wed <key> or 
    echo <key> | wed
~~~

## wgrep : grep contents

~~~
  usage:
    wgrep <q> or 
    echo <q> | wgrep

~~~

## wgrepz :  fzf query

## wkeys : list keys

## wls : list <key|any>

~~~
  usage:
    wls <any>

~~~

## wcat : cat 
~~~
  usage:
    wcat <key> or 
    echo <key> | wview

~~~
## wcatz : fzf view

## wrm : rm 

~~~
  usage:
    wrm <key> or 
    echo <key> | wrm

~~~

## wblank 
~~~
  usage:
    wblank | $EDITOR | wput
~~~
