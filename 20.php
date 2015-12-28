<?php

	$house=1;
    $max = 29000000 / 10;

    function find_divisors($num)
    {
        $max = $num / 2;// twice faster
        $divisors = array($num);// but we have to add one manually

        for($i = 1; $i <= $max; $i ++)
        {
            if($num % $i == 0)
            {
                $divisors[] = $i;
            }
        }
        return $divisors;
    }

    $time_start = microtime(true);

    do 
    {
        $current = array_sum(find_divisors($house));
        //var_dump($current);print "<br/>";
        $house++;

    }
    while($current <= $max);
    
    print "<br/><br/>time: ";
    $time_end = microtime(true);print $time_end - $time_start."<br/><br/>";
    var_dump($current);
    var_dump($house);