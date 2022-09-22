import "../css/app.css"
import "phoenix_html"
import React from 'react';
import ReactDOM from "react-dom";
import App from './App.jsx';

// React 18
const container = document.getElementById('app');
ReactDOM.render(<App />, container)