mkdir -p ~/quiz1
cd quiz1
sum=$(echo 10335 | fold -w1 | paste -sd+ | bc | fold -w1 | paste -sd+ | bc)
files=$(($sum + 10))
words=("spider" "super" "bat")

randomword=$(cat /dev/urandom | tr -dc 'a-z' | head -c $((($RANDOM % 3) + 6)))

seq 1 "$files" | xargs -I number touch "$randomword"-number.txt

for file in $(find . -name "*.txt"); do
    shuf -n "$files" -r -e "${words[@]}" > "$file"
done

for file in $(ls -v *.txt); do
    echo "$PWD/$file" >> ~/quiz1/report.txt
    grep "super"  "$files" -c | xargs -I number echo "number super"  >> ~/quiz1/report.txt
    grep "spider" "$files" -c | xargs -I number echo "number spider" >> ~/quiz1/report.txt
    grep "bat"    "$files" -c | xargs -I number echo "number bat"    >> ~/quiz1report.txt
    echo >> ~/quiz1/report.txt
done
