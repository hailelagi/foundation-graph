/* METAMASK sanity check */
const { ethereum } = window;

export async function checkConnection() {
    try {
        if (!ethereum) {
            alert("Make sure you have metamask!");
            return
        }
    }
    catch (err) {
        console.log(err);
    }

}
