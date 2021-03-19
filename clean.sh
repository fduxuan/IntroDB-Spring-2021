#! /bin/bash

# clean the exported mysql by mysq-workbench

 sed -i '/^\/\*!40/d' "$1"
 sed -i '/^\/\*!50/d' "$1"
 awk '{ gsub(/ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci/,""); print $0 }' "$1" > tmp ; mv tmp "$1"
