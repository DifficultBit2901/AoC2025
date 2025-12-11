mod common;

use std::collections::HashSet;

fn main() {
    match common::get_input() {
        Err(e) => eprintln!("{e}"),
        Ok(input) => {
            let mut old_len = 1;
            let mut new_len = 0;
            let mut ranges = input.ranges;
            while new_len < old_len {
                old_len = ranges.len();
                ranges = reorder_ranges(ranges);
                new_len = ranges.len();
            }
            println!(
                "Result: {}",
                ranges
                    .into_iter()
                    .fold(0, |acc, val| acc + (val.end - val.start + 1))
            );
        }
    }
}

fn reorder_ranges(old_ranges: Vec<common::Range>) -> Vec<common::Range> {
    let mut new_ranges = Vec::new();
    let mut ranges_to_skip = HashSet::new();

    for i in 0..old_ranges.len() {
        if ranges_to_skip.contains(&i) {
            continue;
        }
        let mut range = old_ranges[i].clone();
        for j in (i + 1)..old_ranges.len() {
            let other = &old_ranges[j];
            // Case 1: range i ends before range j starts
            // Case 2: range j ends before range i starts
            if range.end < other.start || other.end < range.start {
                continue;
            }

            // Ranges are not disconnected, can be combined
            range.start = usize::min(range.start, other.start);
            range.end = usize::max(range.end, other.end);
            ranges_to_skip.insert(j);
        }
        new_ranges.push(range);
    }

    new_ranges
}
