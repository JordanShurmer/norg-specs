# Internal Functions (defined by the implementation)
# `neorg/set-property`
# `neorg/from-object` (to convert Neorg nodes to janet nodes)

(defn neorg/abstract-object? [object]
 "Checks if the given object is an abstract object.
  
  An abstract object is an object that has a `:bind` key and its value is a node.
  
  Arguments:
  - object: The object to check.
  
  Returns:
  - true if the object is an abstract object, false otherwise."
 (def binding (get object :bind))
 (and (truthy? binding) (neorg/ast/node? binding)))

(defn neorg/abstract-object [{:bind bound :export export-hook}]
 (unless (neorg/ast/node? bound) (error "Bound value can only be a node!"))
 (unless (function? export-hook) (error "Export hook can only be a function!"))
 {:node bound :export export-hook})

(defn neorg/abstract-object/unbind [abstract-object]
  "Unbinds an abstract object into its bound value and data.
  
  Arguments:
  - abstract-object: The abstract object to unbind.
  
  Returns:
  - A tuple containing the bound value and data of the abstract object.
  
  Throws:
  - An error if the given variable is not an abstract object."
 (unless (neorg/abstract-object? abstract-object) (error "Variable is not an abstract object!"))
 [(get abstract-object :bind) (get abstract-object :data)])

# ------------ AST SECTION ------------
