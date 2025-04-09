
if [[ $arraylengthdcdip -gt 0 ]]; then
  echo -e "\n*** TEST BIG-IQ primary CM => DCD(s)"
  echo -e "************************************"
  for (( i=0; i<${arraylengthdcdip}; i++ ));
  do
    for (( j=0; j<${arraylengthportcmdcd}; j++ ));
    do
        echo -e "\nCheck for ${dcdip2[$i]} port ${portcmdcd[$j]}"
        cat /dev/null | $nc ${dcdip2[$i]} ${portcmdcd[$j]%,*} 2>&1 | grep -v Version | grep -v received | grep -v SSH
    done
    if [[ $latency = "yes"* || $latency = "y"* ]]; then
      echo -e "\nLatency: $(ping ${dcdip2[$i]} -c 100 -i 0.010  | tail -1)"
      echo
    fi
  done
