# colors and vector
c5="ff0000ff" # red
c4="f3632cff" # orange
c3="f8ae3dff" # yellow
c2="fcfc52ff" # greenish
c1="00ff00ff" # green

cs=($c1 $c2 $c3 $c4 $c5)
white="ffffffff"

# minimum acceptable cpu vars
min_temp=30
min_cpu=20
# length of color vector
len=${#cs[@]}
len=$(($len -1))


function update_numpad {

    for i in $(seq 1 9); do
        echo "rgb $1" > /tmp/ckbpipe00$i
    done

}

# write a given color on all the numpad pipes
function decide_numpad_color {

     # define the step
    step=$((100 -$min_cpu))
    step=$(( $step/$len ))

    # for every possible color
    for i in $(seq 0 $len); do
        # get the threshold under which the color will be displayed
        thrs=$(($i*$step+$step))

        # if is under than display
        if [ "$1" -lt "$thrs" ]; then 
            echo $1 "<" $thrs " color :" $i
            update_numpad ${cs[$i]}
            break
        fi

    done

}

function test_colors {
    echo $len
     # for every possible color
    for i in $(seq 0 $len); do

        echo "Using color "$i
        update_numpad ${cs[$i]}
        sleep 1

        

    done
}

# write white to the dec number of $1
function write_number {



    if (( $1>10 )); then 

        dec="${1:0:1}"
        echo "rgb $white" > /tmp/ckbpipe00$dec
    fi

}

# write cpu temp on pipe10
function write_cpu_temp {
    
    # define the step
    step=$(($2-$min_temp))
    step=$(( $step/$len))

     # for every possible color
    for i in $(seq 0 $len); do
        # get the threshold under which the color will be displayed
        thrs=$(($i*$step+$step))

        # if is under than display
        if [ "$1" -lt "$thrs" ]; then 
            echo "rgb ${cs[$i]}" > /tmp/ckbpipe010
            break
        fi

    done
}

while true
do 
    # get cpu usage in percetage
    usage=$(echo $[100-$(vmstat 1 2|tail -1|awk '{print $15}')])
    
    # get cpu temp, high and critical in vector form, and write
    temp=$(sensors | grep -P "Package id 0:  \+([0-9]+)" | grep -oP "[0-9]{2,3}")
    temp=($temp)
    write_cpu_temp ${temp[0]} ${temp[2]} 

    # color number associated with cpu decimal
    write_number $usage

    # update the others' colors
    decide_numpad_color $usage

    echo "----------------------------"
   



done

test_colors