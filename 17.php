<?php

	    $input = "43
3
4
10
21
44
4
6
47
41
34
17
17
44
36
31
46
9
27
38";

        $perms = array();
        $containers = arsort(explode("\n", $input));

        function permute($items, $perms = array( ))
        {
            for ($i = 0; $i < count($items); $i++)
            {
                $perm = array();
                $max = 150;
                $total = 0;

                while ($total <= $max)
                {
                    # code...
                }
            }
        }

        $perms = permute($containers);

        var_dump($perms);