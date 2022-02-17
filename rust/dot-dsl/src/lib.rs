pub mod graph {
    pub mod graph_items {
        pub mod edge {
            use std::collections::HashMap;

            #[derive(Clone, Debug, PartialEq)]
            pub struct Edge {
                pub attrs: HashMap<String, String>,
                pub from: String,
                pub to: String,
            }

            impl Edge {
                pub fn new(from: &str, to: &str) -> Self {
                    Self { attrs: HashMap::new(), from: from.to_string(), to: to.to_string() }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    for (name, value) in attrs {
                        self.attrs.insert(name.to_string(), value.to_string());
                    }

                    self
                }
            }
        }

        pub mod node {
            use std::collections::HashMap;

            #[derive(Clone, Debug, PartialEq)]
            pub struct Node {
                pub name: String,
                pub attrs: HashMap<String, String>,
            }

            impl Node {
                pub fn new(name: &str) -> Self {
                    Self { name: name.to_string(), attrs: HashMap::new() }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    for (name, value) in attrs {
                        self.attrs.insert(name.to_string(), value.to_string());
                    }

                    self
                }

                pub fn get_attr(&self, name: &str) -> Option<&str> {
                    match self.attrs.get(name) {
                        Some(value) => Some(value.as_str()),
                        None => None,
                    }
                }
            }
        }
    }

    use std::collections::HashMap;
    use graph_items::edge::Edge;
    use graph_items::node::Node;

    pub struct Graph {
        pub attrs: HashMap<String, String>,
        pub edges: Vec<Edge>,
        pub nodes: Vec<Node>,
    }

    impl Graph {
        pub fn new() -> Self {
            Self { attrs: HashMap::new(), edges: Vec::new(), nodes: Vec::new() }
        }

        pub fn with_edges(mut self, edges: &[Edge]) -> Self {
            self.edges = edges.to_vec();
            self
        }

        pub fn with_nodes(mut self, nodes: &[Node]) -> Self {
            self.nodes = nodes.to_vec();
            self
        }

        pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
            for (name, value) in attrs {
                self.attrs.insert(name.to_string(), value.to_string());
            }

            self
        }

        pub fn get_node(&self, name: &str) -> Option<&Node> {
            self.nodes.iter().find(|n| n.name == name)
        }
    }
}
