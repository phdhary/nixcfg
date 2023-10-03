totalGenerationCount=$(home-manager generations | awk -F ' ' '{print $5}' | wc -l);
printf "total generation count: %s\n" "$totalGenerationCount";
deleteCount=$(("$totalGenerationCount" - 2));
printf "delete count: %s\n\n" "$deleteCount";
generations=$(home-manager generations | awk -F ' ' '{print $5}' | tail -"$deleteCount" | paste -sd ' ');

if [ "$totalGenerationCount" -gt 4 ]; then
  # printf "home-manager remove-generations %s\n" "$generations";
  home-manager remove-generations $generations
else
  printf "not enough generations\n\n";
fi

home-manager generations
