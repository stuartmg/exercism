#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut stack: Vec<i32> = vec![];

    for input in inputs {
        let result = match input {
            CalculatorInput::Value(val) => Some(*val),
            CalculatorInput::Add => perform(&mut stack, |a, b| a + b),
            CalculatorInput::Subtract => perform(&mut stack, |a, b| a - b),
            CalculatorInput::Multiply => perform(&mut stack, |a, b| a * b),
            CalculatorInput::Divide => perform(&mut stack, |a, b| a / b),
        };

        if let Some(val) = result {
            stack.push(val);
        } else {
            return None;
        }
    }

    if stack.len() == 1 {
        stack.pop()
    } else {
        None
    }
}

fn perform(stack: &mut Vec<i32>, f: impl Fn(i32, i32) -> i32) -> Option<i32> {
    stack
        .pop()
        .and_then(|op2| stack.pop().and_then(|op1| Some(f(op1, op2))))
}
