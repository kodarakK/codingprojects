<?php
$file_content = file_get_contents("puzzleinputp2.txt");
$input = explode("\n", $file_content);
$left = array();
$right = array();
$numbers = array();
foreach ($input as $line) {
    $split = explode("  ", $line);
    foreach ($split as $num) {
    	    array_push($numbers, $num);
    }
}
$numbers = array_slice($numbers, 0, count($numbers)-1);
for ($i = 0; $i < count($numbers); $i+=2) {
    array_push($left, $numbers[$i]);
    array_push($right, $numbers[$i+1]);
}
sort($left);
sort($right);

$sim_scores = array();

function count_nums($numbers, $snum) {
	 $count = 0;
	 foreach ($numbers as $num) {
	 	if ($num == $snum) {
		   $count += 1;
		}
	 }
	 return $count;
}
$sum = 0;
foreach ($left as $num) {
	$sum += $num * count_nums($right, $num);
}

var_dump($sum);

?>
