<?php
$file = file_get_contents("p1input.txt");
$pattern = "/(?:mul\([0-9]{1,3},[0-9]{1,3}\))|(?:do\(\))|(?:don\'t\(\))/";

preg_match_all($pattern, $file, $matches, PREG_SET_ORDER);

$do = true;
$acc = 0;
foreach  ($matches as $val) {
	$match = $val[0];

	if ($match === 'do()') {
		$do = true;
	} if ($match === 'don\t()') {
		$do = false;
	} if (str_starts_with($match,'mul')) {
		if ($do) {
			preg_match_all("/(\d{1,3}),(\d{1,3})/", $match, $numbers);
			$acc = $acc + ($numbers[1][0] * $numbers[2][0]);
		}
	}
}

var_dump($acc);


?>
