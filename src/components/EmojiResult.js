import React from 'react';
import "./EmojiResult.css";

function EmojiRow(props){
    return (
        <div className='row__box'>
            <span className='symbol'>{props.symbol}</span>
            <span className='title'>{props.title}</span>
        </div>
    );
}

class EmojiResult extends React.Component {
    constructor(props){
        super(props);
    }
    render(){
        return (
            <div className='result__box'>
                {
                    this.props.emojies.map(
                        (emoji, i) => <EmojiRow symbol={emoji.symbol} title={emoji.title} key={i}/>
                    )
                }
            </div>
        );
    }
}

export default EmojiResult;