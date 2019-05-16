# react-component-generator
Ruby DSL to generate react component.

## Prerequisites.
- Ruby installed.

## How to use.
### 1. Write your configuration file.
sample.rb
```
url ["purchase", "item"]

container "PurchaseItemPage" do
    child "PageTitle"
    child "ItemInfo"
    child "PurchaseButton" 
end

component "ItemInfo" do
    child "ItemIcon"
    child "ItemType"
    child "ItemName"
    child "ItemDetailLink"
end
```

### 2. Run dsl script.
```
ruby .\dsl.rb .\sample.rb
```

### 3. Check generated files.
```
  results
    ├─components
    │  └─purchase
    │      └─item
    │              pageTitle.js
    │              itemInfo.js
    │              purchaseButton.js
    │              itemIcon.js
    │              itemType.js
    │              itemName.js
    │              itemDetailLink.js
    │              
    └─containers
        └─purchase
                purchaseItemPage.js
               
```

#### Container component.
```
import React, { Component } from "react";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import styled from "styled-components";
import PageTitle from "../../components/purchase/item/pageTitle";
import ItemInfo from "../../components/purchase/item/itemInfo";
import PurchaseButton from "../../components/purchase/item/purchaseButton";

const StyledPurchaseItemPage = styled.div`
`;

class PurchaseItemPage extends Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
  }

  compounentUnmount() {
  }

  componentDidUpdate() {
  }

  render() {
    const {
    } = this.props;

    return (
      <StyledPurchaseItemPage>
        <PageTitle />
        <ItemInfo />
        <PurchaseButton />
      </StyledPurchaseItemPage>
    );
  }
}

const mapStateToProps = state => {
  return {...state};
};

const actionCreators = {
};

const enhance = C => {
  const connected = connect(
    mapStateToProps,
    actionCreators
  )(C);
  return withRouter(connected);
};

export default enhance(PurchaseItemPage);
```

#### Presentational component.
```
import React from "react";
import styled from "styled-components";
import ItemIcon from "./itemIcon";
import ItemType from "./itemType";
import ItemName from "./itemName";
import ItemDetailLink from "./itemDetailLink";

const StyledItemInfo = styled.div`
`;

const ItemInfo = (props) => {
    const {
    } = props;
    return (
        <StyledItemInfo className="item-info">
            <ItemIcon />
            <ItemType />
            <ItemName />
            <ItemDetailLink />
        </StyledItemInfo>
    );
};

export default ItemInfo;
```

## Customized templates.
If you want to use own templates, please replace the template files.
- template.container.erb
- template.component.erb

## Dependent packages.
- react
- react-redux
- react-router-dom
- styled-component