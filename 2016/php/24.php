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
        $quantums = array();
        $lowest = false;

        function run($packages, $balance)
        {
            $d = [];

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

            return $d = [$comp1, $comp2, $comp3];
        }

        function quantum($packages)
        {
            $packages['quantum'] = 1;

            foreach ($packages as $p)
            {
                $packages['quantum'] *= $p;
            }

            return $packages['quantum'];
        }

        for($i=0; $i<200; $i++)
        {
            $result = run($packages, $balance);
            $quantums = [quantum($result[0]), quantum($result[1]), quantum($result[2])];
            if(!$lowest || min($quantums) < $lowest){ $lowest = min($quantums); }
        }

        print $lowest;