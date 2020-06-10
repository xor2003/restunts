<?php

//$l = 'node: { title: "364" label: "CopyToSprite1_2" color: 76 textcolor: 73 bordercolor: black }';
//$l = 'edge: { sourcename: "1" targetname: "2" }';

//$r = preg_match_all( $edge, $l, $res );

$node = '/^node:\s*\{\s*title:\s*"([0-9]+)"\s*label:\s*"(.*?)"/';
$edge = '/^edge:\s*\{\s*sourcename:\s*"([0-9]+)"\s*targetname:\s*"([0-9]+)"\s*\}/';

$fc = file('game.gdl');

$out = '<section name="xgml">'."\n".'<section name="graph">'."\n";

$c = 0;

foreach( $fc as $line )
{
  $l = trim($line);

  //echo($l."\n");

  if( preg_match( $node, $l, $res ) )
  {
    //print_r($res);
    $out .= '<section name="node"><attribute key="id" type="int">'.$res[1].'</attribute><attribute key="label" type="String">'.$res[2].'</attribute></section>'."\n";
  }

  if( preg_match( $edge, $l, $res ) )
  {
    //print_r($res);
    $out .= '<section name="edge"><attribute key="source" type="int">'.$res[1].'</attribute><attribute key="target" type="int">'.$res[2].'</attribute></section>'."\n";
  }

$c++;

//if( $c > 100 ) break;
}

$out .= '</section>'."\n".'</section>'."\n";

file_put_contents( 'game.xgml', $out );

?>
