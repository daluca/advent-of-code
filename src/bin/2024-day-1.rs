use advent_of_code::read_from_file;
use std::env;

fn part_one() -> i32 {
    let args: Vec<String> = env::args().collect();
    let input_path = &args[2];

    let input = read_from_file(input_path.to_string());
    let inputs: Vec<&str> = input.split("\n").collect();

    let mut left = Vec::<i32>::new();
    let mut right = Vec::<i32>::new();

    for line in &inputs {
        if line.is_empty() {
            continue;
        }

        let mut iter = line.split_whitespace();

        let lhs: i32 = iter
            .next()
            .expect("Inputs not formatted as expected")
            .parse()
            .expect("Should be an int");
        let rhs: i32 = iter
            .next()
            .expect("Inputs not formatted as expected")
            .parse()
            .expect("Should be an int");

        left.push(lhs);
        right.push(rhs);
    }

    let mut sum = 0;

    left.sort();
    right.sort();

    let mut left = left.iter();
    let mut right = right.iter();

    if left.len() == right.len() {
        for _ in 1..=left.len() {
            let lhs = left.next().expect("Line should exist");
            let rhs = right.next().expect("Line should exist");

            let diff = (lhs - rhs).abs();
            sum += diff;
        }
    }

    sum
}

fn part_two() -> i32 {
    let args: Vec<String> = env::args().collect();
    let input_path = &args[2];

    let input = read_from_file(input_path.to_string());
    let inputs: Vec<&str> = input.split("\n").collect();

    let mut left = Vec::<i32>::new();
    let mut right = Vec::<i32>::new();

    for line in &inputs {
        if line.is_empty() {
            continue;
        }

        let mut iter = line.split_whitespace();

        let lhs: i32 = iter
            .next()
            .expect("Inputs not formatted as expected")
            .parse()
            .expect("Should be an int");
        let rhs: i32 = iter
            .next()
            .expect("Inputs not formatted as expected")
            .parse()
            .expect("Should be an int");

        left.push(lhs);
        right.push(rhs);
    }

    let mut sum = 0;

    for lhs in left.iter() {
        let count: i32 = right
            .iter()
            .filter(|&n| *n == *lhs)
            .count()
            .try_into()
            .unwrap();
        let diff = lhs * count;

        sum += diff;
    }

    sum
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let part = &args[1];

    let answer = if part == "--part-one" {
        part_one()
    } else if part == "--part-two" {
        part_two()
    } else {
        -1
    };

    if answer > 0 {
        println!("{:?}", answer);
    } else {
        println!("Please specify a part");
    }
}
