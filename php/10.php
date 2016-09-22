<?php        

        $input = '1321131112';

        function process($string)
        {
            $i = 1;
            $total = strlen($string);
            $digits = str_split($string);
            $current = false;
            $count = false;
            $output = false;

            foreach ($digits as $d)
            {
                $last = $i === $total;

                if($current !== $d)
                {
                    if($current){ $output .= $count.$current; }

                    $current = $d;
                    $count = 1;
                }
                else
                {
                    $count++;
                }

                if($last){ $output .= $count.$current; }

                $i++;
            }

            return $output;
        }

        for($i=0; $i<50;$i++)
        {
            $input = process($input);
        }

        var_dump($input);