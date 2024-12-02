token := `cat .session-token`

[private]
default:
    @just --list

clippy:
    cargo clippy -q

rustfmt:
    cargo fmt

run year day part: rustfmt clippy
    cargo -q run --bin {{ year }}-day-{{ day }} -- --part-{{ part }} inputs/{{ year }}-day-{{ day }}.txt

get-puzzle-input year day:
    curl -s --header "Cookie: session={{ token }}" https://adventofcode.com/{{ year }}/day/{{ day }}/input -o inputs/{{ year }}-day-{{ day }}.txt
