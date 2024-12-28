#!/bin/bash
docker compose exec -ti mailserver setup "$@"

function postfix_format_dns_record() {
  local file=$1
  local formated_file="${file}.formated"

  printf "\033[1mAdd or Update your DNS records\033[0m\n\n"

  dns_record=$(perl -e '
     $_ = join(" ", (map {chomp; $_} <>));
     s/^(.*)\s+?\t?+IN.*?(".*").*$/$1 TXT $2\n/;
     s/"\s*"//g;
     print
  ' "$1" > "$formated_file"
  )
  output=$(awk '{print "\033[1mRecord:\033[0m " $1 "\n\033[1mTYPE:\033[0m "$2 "\n\033[1mValue:\033[0m "} {for(i=3;i<=NF;++i) printf $i}' "$formated_file")
  echo "$output"
}

if [ "$2" == "dkim" ]; then
  for key in data/mailserver/config/opendkim/keys/*; do
    postfix_format_dns_record "${key}/mail.txt"
  done
fi

