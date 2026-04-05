<?php
$file = file_get_contents("p1input.txt");
$pattern = "/mul\([0-9]{1,3},[0-9]{1,3}\)/";
preg_match_all($pattern, $file, $matches, PREG_SET_ORDER); 
$acc = 0;
foreach ($matches as $val) {
    preg_match_all("/[0-9]{1,3},[0-9]{1,3}/", $val[0], $more_matches, PREG_SET_ORDER);
    foreach ($more_matches as $more_val ) {
$numbers = explode(",", $more_val[0]);
for ($x = 0; $x < count($numbers); $x = $x + 2) {
$acc = $acc + ($numbers[$x] * $numbers[$x+1]);
}
    }}
echo $acc;
?>
