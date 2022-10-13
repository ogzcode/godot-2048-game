import emojilist from "./json/emojiList.json";

function filterEmojies(searchText, maxResult){
    return emojilist.filter(emoji => {
        if (emoji.title.toLocaleLowerCase().includes(searchText.toLocaleLowerCase())){
            return true;
        }
        if (emoji.keywords.includes(searchText.toLocaleLowerCase())){
            return true;
        }
        return false;
    }).slice(0, maxResult);
}

export default filterEmojies;