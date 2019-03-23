# find folders larger than 1GB 
du -sh *  | grep -E "\dG"
