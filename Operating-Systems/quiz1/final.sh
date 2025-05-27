mkdir -p $PWD/quiz-1
cd quiz-1

echo -n "Enter your AEM:"
read -r AEM
sum=$(echo $AEM | fold -w1 | paste -sd+ | bc | fold -w1 | paste -sd+ | bc)

files=$(($sum + 10))
words=("spider" "super" "bat")

randomword=$(cat /dev/urandom | tr -dc 'a-z' | head -c $((($RANDOM % 3) + 6))) 
seq 1 "$files" | xargs -I number touch "$randomword"-number.txt

for file in $(find . -name "*.txt"); do
    shuf -n "$files" -r -e "${words[@]}" > "$file"
done

for file in $(ls -v *.txt); do
    echo "$PWD/$file" >> report.txt
    grep "super"   "$file" -c | xargs -I number echo "number super"   >> report.txt
    grep "spider"  "$file" -c | xargs -I number echo "number spider"  >> report.txt
    grep "bat"     "$file" -c | xargs -I number echo "number bat"     >> report.txt
    echo >> report.txt
done


# find . -name "*.txt" -print0 | xargs -0 -I {} shuf -n "$files" -r -e "${words[@]}" > {}
# ls *.txt | xargs -I {} shuf -n "$files" -r -e "${words[@]}" > {}
# seq 1 "$files" | xargs -I number shuf -n "$files" -r -e "${words[@]}" > "$randomword"-number.txt 
