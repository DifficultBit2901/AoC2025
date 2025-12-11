#[derive(Debug)]
pub struct Input {
    pub ranges: Vec<Range>,
    pub nums: Vec<usize>,
}

impl Input {
    pub fn get_nums_outside_range(self: &Self) -> Vec<usize> {
        let mut res = Vec::new();

        'outer: for num in &self.nums {
            for range in &self.ranges {
                if *num > range.start && *num <= range.end {
                    res.push(*num);
                    continue 'outer;
                }
            }
        }

        res
    }
}

#[derive(Debug, Clone)]
pub struct Range {
    pub start: usize,
    pub end: usize,
}

pub fn get_input() -> Result<Input, String> {
    let mut ranges = Vec::new();
    let mut nums = Vec::new();

    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        return Err(format!("Usage: {} <input-file>", args[0]));
    }

    let contents = std::fs::read_to_string(&args[1]);
    match contents {
        Err(e) => return Err(format!("Failed to read {}: {}", args[1], e)),
        Ok(content) => {
            let mut i = 0;
            let lines: Vec<&str> = content.lines().map(str::trim).collect();
            loop {
                let l = lines.get(i);
                i += 1;
                if let Some(line) = l {
                    if line.len() == 0 {
                        break;
                    }
                    let parts: Vec<&str> = line.split("-").collect();
                    let start = usize::from_str_radix(parts[0], 10).unwrap();
                    let end = usize::from_str_radix(parts[1], 10).unwrap();
                    ranges.push(Range { start, end });
                } else {
                    break;
                }
            }

            while i < lines.len() {
                let l = lines.get(i).unwrap();
                if l.len() == 0 {
                    break;
                }
                let num = usize::from_str_radix(l, 10).unwrap();
                nums.push(num);
                i += 1;
            }
        }
    }

    Ok(Input { ranges, nums })
}
