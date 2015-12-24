<?php

        $input = "1
3
5
11
13
17
19
23
29
31
37
41
43
47
53
59
67
71
73
79
83
89
97
101
103
107
109
113";
        
    $packages = explode("\n", $input);
    $balance = false;

    while(!$balance || $sum_of_all == 0)
    {
        $comp1 = array();
        $comp2 = array();
        $comp3 = array();

        rsort($packages);
        //shuffle($packages);

        foreach ($packages as $p)
        {
            $rand = rand(1,3);
            $rand_comp = &${'comp'.$rand};
            array_push($rand_comp, $p);
        }

        $sum_of_all = array_sum($comp1) + array_sum($comp2) + array_sum($comp3);
        $balance = array_sum($comp1) == array_sum($comp2) && array_sum($comp2) == array_sum($comp3);
    }

    function quantum($packages)
    {
        $packages['quantum'] = 1;

        foreach ($packages as $p)
        {
            $packages['quantum'] *= $p;
        }

        return $packages;
    }

    var_dump(quantum($comp1), quantum($comp2), quantum($comp3));