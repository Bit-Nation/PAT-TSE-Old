import React, { Component } from 'react';
import { Grid, Row, Col, Input, ButtonInput } from 'react-bootstrap';
import ICOForm from './ico_form.jsx';
import ICOConfirmation from './ico_confirmation.jsx';
import Web3 from 'web3';

class ICO extends Component {

  constructor() {
    super();
    this.state = {
      dataEntered: false,
      error: null
    };
  }

  saveValues(values) {
    this.setState({data: values, dataEntered: true});
  }

  componentDidMount() {
    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
    if (typeof web3 !== 'undefined') {
      // Use Mist/MetaMask's provider
      window.web3 = new Web3(web3.currentProvider);
    } else {
      this.setState({error: "Can't load Web3, please use Mist or Metamask."});
    }
  }

  render() {

    let content;

    if (this.state.error !== null) {
      content = <Alert bsStyle="danger" className="text-center">
        <p>Looks like there was an issue while loading Web3.</p>
        <p>Please consider using Mist or Metamask.</p>
      </Alert>;
    } else if(!this.state.dataEntered) {
      content = <ICOForm saveValues={this.saveValues.bind(this)}/>;
    } else {
      content = <ICOConfirmation data={this.state.data}/>;
    }
    return (
      <Grid>
        { content }
        <hr />
        <footer>
          <p className="text-center"><a href="https://bitnation.co/">Bitnation</a> crowdsale DAPP.</p>
        </footer>
      </Grid>
    );
  }
}

export default ICO;

