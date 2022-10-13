import React from 'react';
import "./SearchEmoji.css";

class Search extends React.Component {
    constructor(props){
        super(props);
        this.handleChange = this.handleChange.bind(this);
    }
    handleChange(event){
        this.props.onTextChange(event.target.value);
    }
    render(){
        return (
            <div className='search__box'>
                <h1>Search Emoji</h1>
                <input className='input' type="text" placeholder='Search Emoji' onChange={this.handleChange}/>
            </div>
        );
    }
}

export default Search;