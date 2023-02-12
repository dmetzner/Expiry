```
users: {
    <user_id>: {
        name: <string>,
        icon: <string>,
        group_ids: [<group_id1>, <group_id2>, ...]
    }
}

groups: {
    <group_id>: {
        name: <string>,
        user_ids: [<user_id1>, <user_id2>, ...],
        products: [<product_id1>, <product_id2>, ...]
    }
}

products: {
    <product_id>: {
        name: <string>,
        description: <string>,
        price: <float>,
        added_by: <user_id>,
        added_at: <timestamp>,
        edited_by: <user_id>,
        edited_at: <timestamp>
    }
}
```