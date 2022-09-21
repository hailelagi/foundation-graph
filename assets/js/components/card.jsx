import React from "react";
import styled from "styled-components";

export default function Card(props) {
    return (
        <CardBox>
            "hello"
        </CardBox>
    );
}

const CardBox = styled.div`
  width: 250px;
  height: 250px;
  padding: 1em;
  margin: 0.5em;
  border-radius: 15px;
  font-family: sans-serif;
  font-weight: 500;
  font-size: 110%;
`;