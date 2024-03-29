#[macro_export]
macro_rules! hashmap {
    ( $( $($k:expr => $v:expr)+ $(,)? )* ) => {
        {
            let mut temp_map = ::std::collections::HashMap::new();
            $($(temp_map.insert($k, $v);)+)*
            temp_map
        }
    };
}
