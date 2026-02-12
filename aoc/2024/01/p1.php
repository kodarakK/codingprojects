<?php
$file_content = file_get_contents("input.txt");

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
$sum = 0;
for ($i = 0; $i < count($left); $i++) {
    $sum += abs($left[$i] - $right[$i]);
}

echo $sum. "\n";
?>
